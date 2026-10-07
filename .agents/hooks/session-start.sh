#!/bin/sh
# Evento: início da sessão. Coloca o estado atual do projeto no contexto do agente.

root=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
status="$root/docs/STATUS.md"

if [ -f "$status" ]; then
  echo "=== docs/STATUS.md ==="
  sed -n '1,60p' "$status"
  echo
fi

echo "Lembrete: defina o nível (Rápido/Padrão/Grande) e o tipo do pedido — AGENTS.md §3 e §4."
exit 0
