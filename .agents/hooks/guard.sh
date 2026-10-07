#!/bin/sh
# Evento: antes de executar um comando ou editar um arquivo.
# Bloqueia o que é exclusivo do humano (versionar, publicar, ações destrutivas, segredos).
# Entrada (stdin): JSON da ferramenta com "command" ou "file_path", ou texto puro com o comando.
# Saída: 0 = segue; 2 = bloqueia (a mensagem em stderr volta para o agente).

INPUT=$(cat)

field() {
  printf '%s\n' "$INPUT" | sed -n "s/.*\"$1\"[[:space:]]*:[[:space:]]*\"\([^\"]*\)\".*/\1/p" | head -n 1
}

block() {
  echo "BLOQUEADO: $1" >&2
  exit 2
}

# ---------- Edição de arquivos ----------
path=$(field file_path)
if [ -n "$path" ]; then
  case "$(basename "$path")" in
    .env.example) ;;
    .env|.env.*) block "arquivos .env guardam segredos. Atualize .env.example e docs/setup.md." ;;
    *.pem|*.key|*.p12|*.pfx|id_rsa*|id_ed25519*) block "chaves e certificados não são editados por agentes." ;;
  esac
  case "$path" in
    */.git/*|.git/*) block "a pasta .git não é editada diretamente." ;;
  esac
  exit 0
fi

# ---------- Comandos ----------
cmd=$(field command)
if [ -z "$cmd" ]; then
  printf '%s' "$INPUT" | grep -q '^[[:space:]]*{' && exit 0
  cmd=$INPUT
fi

check() {
  printf '%s' "$cmd" | grep -qiE -e "$1" && block "$2 Comando: $cmd"
}

GIT='(^|[;&|(`[:space:]])git([[:space:]]+[^;&|]*)?[[:space:]]'
check "${GIT}(add|commit|push|merge|rebase|tag|cherry-pick|revert|am)([[:space:]]|\$)" \
  "versionar e publicar é do humano. Entregue a proposta de commit (skill wrap-up)."
check "${GIT}reset[[:space:]]+[^;&|]*--hard" "reset --hard descarta trabalho."
check "${GIT}clean[[:space:]]+-[a-z]*f" "git clean apaga arquivos não versionados."
check "${GIT}stash[[:space:]]+(drop|clear)" "descartar stash apaga trabalho guardado."
check '--no-verify' "pular hooks de Git burla as verificações."
check '(^|[;&|[:space:]])(gh|glab)[[:space:]]+((pr|mr)[[:space:]]+(create|merge|close|ready|review|approve|edit)|release[[:space:]]+create)' \
  "PRs e releases são do humano. Entregue a descrição pronta (skill wrap-up)."
check 'rm[[:space:]]+-[a-z]*r[a-z]*f?[a-z]*[[:space:]]+(/|~|\*|\.)([[:space:]]|$)' "remoção recursiva da raiz, home ou diretório inteiro."
check 'drop[[:space:]]+(database|schema|table)' "remoção de estrutura de dados."
check 'truncate[[:space:]]+(table[[:space:]]+)?[a-z_]' "remoção de todos os dados de uma tabela."

exit 0
