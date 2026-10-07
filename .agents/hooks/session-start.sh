#!/bin/sh
# Evento: início da sessão.
# Coloca no contexto do agente o estado atual do projeto e a fronteira de tickets.

. "$(dirname "$0")/lib.sh"

root=$(project_root)
status="$root/docs/progress/STATUS.md"
tasks="$root/tasks/README.md"

if [ -f "$status" ]; then
  echo "=== Estado atual do projeto (docs/progress/STATUS.md) ==="
  sed -n '1,80p' "$status"
fi

if [ -f "$tasks" ]; then
  echo
  echo "=== Fronteira de tickets (tasks/README.md) ==="
  sed -n '/^## Fronteira atual/,/^## /p' "$tasks" | sed '$d'
fi

echo
echo "Lembrete: classifique o pedido na seção 3 do AGENTS.md e siga a skill indicada até o Fechamento."
exit 0
