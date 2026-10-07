# Hooks

Scripts que a **ferramenta** executa automaticamente em eventos do agente. Diferente de rules e skills (pedidos ao modelo, que ele pode esquecer), hooks sempre rodam. Use-os para o que não pode falhar.

Scripts POSIX `sh`, sem dependências (Linux, macOS, Windows via Git Bash ou WSL).

| Script | Evento | O que faz | Configurar |
| --- | --- | --- | --- |
| `session-start.sh` | Início da sessão | Mostra o `docs/STATUS.md` ao agente | — |
| `guard.sh` | Antes de comando **e** antes de editar arquivo | Bloqueia `git add/commit/push/merge/rebase/tag/cherry-pick/revert`, `reset --hard`, `clean -f`, `stash drop`, `--no-verify`, criação/merge de PR e release (`gh`, `glab`), `rm -rf` amplo, `DROP`/`TRUNCATE`; e edição de `.env*`, chaves, certificados e `.git/` | Acrescente padrões com `check` |
| `post-edit.sh` | Depois de editar arquivo | Formata e roda lint no arquivo; erro de lint volta para o agente | `FORMAT_CMD`, `LINT_CMD` |

**Convenção:** o evento chega por stdin (JSON da ferramenta ou texto puro). Saída `0` deixa seguir; `2` bloqueia e a mensagem de stderr volta para o agente.

## Ligar à ferramenta

Exemplo para Claude Code em [`examples/claude-code-settings.json`](examples/claude-code-settings.json) (copie para `.claude/settings.json`). Em outra ferramenta, mapeie: início de sessão → `session-start.sh`; antes de comando ou edição → `guard.sh`; depois de edição → `post-edit.sh`.

## Testar

```sh
printf '{"tool_input":{"command":"git commit -m x"}}' | sh .agents/hooks/guard.sh; echo "saída: $?"
# BLOQUEADO: versionar e publicar é do humano. ...   saída: 2
```
