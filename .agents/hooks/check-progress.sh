#!/bin/sh
# Evento: fim da resposta do agente.
# Se há arquivos alterados fora da documentação e nada foi registrado em docs/progress/,
# lembra o agente de registrar o progresso antes de encerrar.
#
# STRICT=1 devolve o lembrete ao agente (ele precisa agir); STRICT=0 apenas avisa.
STRICT=1

. "$(dirname "$0")/lib.sh"
read_input

# Evita laço: se o agente já está respondendo a este lembrete, não insiste.
if printf '%s' "$INPUT" | grep -qE '"stop_hook_active"[[:space:]]*:[[:space:]]*true'; then
  exit 0
fi

git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0

changes=$(git status --porcelain 2>/dev/null)
[ -n "$changes" ] || exit 0

work=$(printf '%s\n' "$changes" | grep -vE '[[:space:]](docs/|\.agents/|tasks/|AGENTS\.md|CLAUDE\.md|CHANGELOG\.md|README\.md)' )
progress=$(printf '%s\n' "$changes" | grep -E '[[:space:]]docs/progress/')

if [ -n "$work" ] && [ -z "$progress" ]; then
  msg="Há arquivos alterados e nenhum registro em docs/progress/. Se o trabalho terminou, execute a skill update-progress; se ainda está em andamento, diga isso ao usuário."
  if [ "$STRICT" = "1" ]; then
    echo "$msg" >&2
    exit 2
  fi
  echo "$msg"
fi

exit 0
