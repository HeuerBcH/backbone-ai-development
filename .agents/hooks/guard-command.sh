#!/bin/sh
# Evento: antes de executar um comando de terminal.
# Bloqueia operações exclusivas do humano (versionar, publicar, integrar) e comandos
# irreversíveis. Ver .agents/rules/git-workflow.md.
# Para executar um comando bloqueado, o humano o roda por conta própria.

. "$(dirname "$0")/lib.sh"
read_input

cmd=$(extract_field command)
[ -n "$cmd" ] || cmd="$INPUT"

check() {
  if printf '%s' "$cmd" | grep -qiE -e "$1"; then
    block "$2 Comando: $cmd"
  fi
}

# Git: tudo que grava histórico, publica ou integra é do humano.
# Aceita opções antes do subcomando (ex.: git -C pasta commit).
GIT='(^|[;&|(`[:space:]])git([[:space:]]+[^;&|]*)?[[:space:]]'
check "${GIT}(commit|push|merge|rebase|tag|cherry-pick|revert|am)([[:space:]]|\$)" \
  "commits, push, merge, rebase, tags e reverts são feitos pelo humano. Entregue a proposta de commit (skill prepare-commit)."
check "${GIT}reset[[:space:]]+[^;&|]*--hard" "reset --hard descarta trabalho não commitado."
check "${GIT}clean[[:space:]]+-[a-z]*f" "git clean apaga arquivos não versionados."
check "${GIT}stash[[:space:]]+(drop|clear)" "descartar stash apaga trabalho guardado."
check '--no-verify' "pular hooks de Git burla as verificações do projeto."

# Pull requests, merge requests e releases são do humano.
check '(^|[;&|[:space:]])gh[[:space:]]+(pr[[:space:]]+(create|merge|close|ready|review|edit)|release[[:space:]]+create)' \
  "PRs e releases são criados e mesclados pelo humano. Entregue a descrição pronta (skill prepare-commit)."
check '(^|[;&|[:space:]])glab[[:space:]]+(mr[[:space:]]+(create|merge|close|approve)|release[[:space:]]+create)' \
  "merge requests e releases são do humano. Entregue a descrição pronta (skill prepare-commit)."

# Remoções irreversíveis.
check 'rm[[:space:]]+-[a-z]*r[a-z]*f?[a-z]*[[:space:]]+(/|~|\*|\.)([[:space:]]|$)' "remoção recursiva da raiz, home ou diretório inteiro."
check 'drop[[:space:]]+(database|schema|table)' "remoção de estrutura de dados."
check 'truncate[[:space:]]+(table[[:space:]]+)?[a-z_]' "remoção de todos os dados de uma tabela."

exit 0
