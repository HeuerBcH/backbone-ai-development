#!/bin/sh
# Evento: antes de criar ou editar um arquivo.
# Bloqueia escrita em arquivos de segredo e em artefatos gerados.

. "$(dirname "$0")/lib.sh"
read_input

path=$(extract_field file_path)
[ -n "$path" ] || path=$(extract_field path)
[ -n "$path" ] || exit 0

name=$(basename "$path")

case "$name" in
  .env.example) exit 0 ;;
  .env|.env.*) block "arquivos .env guardam segredos e não são editados por agentes. Atualize .env.example e docs/setup.md." ;;
  *.pem|*.key|*.p12|*.pfx|id_rsa*|id_ed25519*) block "chaves e certificados não são editados por agentes." ;;
esac

# Artefatos gerados: edite a fonte, não o resultado.
# Adicione aqui os lockfiles e pastas geradas do projeto, ex.: */dist/*|*/build/*
case "$path" in
  */.git/*) block "a pasta .git não é editada diretamente." ;;
esac

exit 0
