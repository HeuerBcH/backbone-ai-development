#!/bin/sh
# Funções compartilhadas pelos hooks. Não é um hook: é carregado pelos outros scripts.
#
# Convenção de entrada: o evento chega via stdin, seja como JSON da ferramenta
# (ex.: {"tool_input": {"command": "..."}}) ou como texto puro.
# Convenção de saída: 0 = segue; 2 = bloqueia (a mensagem em stderr volta para o agente).

# Lê todo o stdin uma única vez.
read_input() {
  INPUT=$(cat)
}

# Extrai o valor de uma chave JSON simples ("chave": "valor") da entrada.
# Se a entrada não for JSON, devolve a primeira linha do texto puro.
extract_field() {
  value=$(printf '%s\n' "$INPUT" | sed -n "s/.*\"$1\"[[:space:]]*:[[:space:]]*\"\([^\"]*\)\".*/\1/p" | head -n 1)
  if [ -z "$value" ] && ! printf '%s' "$INPUT" | grep -q '^[[:space:]]*{'; then
    value=$(printf '%s\n' "$INPUT" | head -n 1)
  fi
  printf '%s' "$value"
}

# Raiz do repositório (ou diretório atual, fora de um repositório Git).
project_root() {
  git rev-parse --show-toplevel 2>/dev/null || pwd
}

block() {
  echo "BLOQUEADO pelo hook: $1" >&2
  exit 2
}
