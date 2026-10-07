#!/bin/sh
# Evento: depois de criar ou editar um arquivo.
# Formata e verifica o arquivo alterado com as ferramentas do projeto.
#
# Configure os comandos abaixo. O caminho do arquivo é passado como último argumento.
# Deixe vazio para desativar.
FORMAT_CMD=""
LINT_CMD=""

. "$(dirname "$0")/lib.sh"
read_input

[ -n "$FORMAT_CMD$LINT_CMD" ] || exit 0

path=$(extract_field file_path)
[ -n "$path" ] || path=$(extract_field path)
[ -f "$path" ] || exit 0

if [ -n "$FORMAT_CMD" ]; then
  $FORMAT_CMD "$path" >/dev/null 2>&1 || echo "Aviso: formatação falhou em $path" >&2
fi

if [ -n "$LINT_CMD" ]; then
  if ! output=$($LINT_CMD "$path" 2>&1); then
    echo "Lint encontrou problemas em $path:" >&2
    echo "$output" >&2
    exit 2
  fi
fi

exit 0
