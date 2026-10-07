#!/bin/sh
# Evento: depois de editar um arquivo. Formata e verifica o arquivo com as ferramentas do projeto.
# Configure os comandos (o caminho do arquivo é passado como último argumento). Vazio = desativado.
FORMAT_CMD=""
LINT_CMD=""

[ -n "$FORMAT_CMD$LINT_CMD" ] || exit 0

INPUT=$(cat)
path=$(printf '%s\n' "$INPUT" | sed -n 's/.*"file_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -n 1)
[ -f "$path" ] || exit 0

if [ -n "$FORMAT_CMD" ]; then
  $FORMAT_CMD "$path" >/dev/null 2>&1 || echo "Aviso: formatação falhou em $path" >&2
fi

if [ -n "$LINT_CMD" ] && ! output=$($LINT_CMD "$path" 2>&1); then
  echo "Lint encontrou problemas em $path:" >&2
  echo "$output" >&2
  exit 2
fi

exit 0
