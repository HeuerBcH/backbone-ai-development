# Hooks

Hooks são **comandos executados automaticamente pela ferramenta do agente em eventos do seu ciclo de vida**. A diferença para rules e skills é fundamental:

- Rule/skill é um **pedido** ao modelo — ele pode esquecer ou interpretar errado.
- Hook é **determinístico** — a ferramenta executa sempre, sem depender do modelo.

Use hooks para tudo que **não pode falhar**: bloquear ações perigosas, formatar, validar, lembrar de registrar.

## Scripts desta pasta

Scripts POSIX `sh` (rodam em Linux, macOS e Windows via Git Bash ou WSL), sem dependências externas.

| Script | Evento | O que faz | Configuração |
| --- | --- | --- | --- |
| `session-start.sh` | Início da sessão | Imprime o `STATUS.md` e a fronteira de tickets para o agente começar sabendo o estado | — |
| `guard-command.sh` | Antes de comando de terminal | Bloqueia tudo que é do humano no Git (`commit`, `push`, `merge`, `rebase`, `tag`, `cherry-pick`, `revert`), criação/merge de PR e release (`gh`, `glab`), além de `reset --hard`, `clean -f`, `stash drop`, `--no-verify`, `rm -rf` na raiz/diretório inteiro e `DROP`/`TRUNCATE` | Acrescente padrões na lista `check` |
| `guard-files.sh` | Antes de criar/editar arquivo | Bloqueia `.env*` (exceto `.env.example`), chaves, certificados e `.git/` | Acrescente artefatos gerados do projeto no segundo `case` |
| `post-edit.sh` | Depois de criar/editar arquivo | Roda o formatador e o lint do projeto no arquivo alterado; lint com erro volta para o agente | Preencha `FORMAT_CMD` e `LINT_CMD` |
| `check-progress.sh` | Fim da resposta | Se há arquivos de trabalho alterados e nada em `docs/progress/`, pede ao agente para registrar o progresso | `STRICT=1` exige ação; `STRICT=0` só avisa |
| `lib.sh` | — | Funções compartilhadas (leitura da entrada, extração de campos, bloqueio) | — |

## Convenção de entrada e saída

- **Entrada:** o evento chega via stdin, como JSON da ferramenta (`{"tool_input": {"command": "..."}}`, `{"tool_input": {"file_path": "..."}}`) ou como texto puro. Os scripts entendem os dois.
- **Saída:** código `0` deixa a ação seguir; código `2` bloqueia e a mensagem em stderr é devolvida ao agente, que corrige o rumo.

Se a ferramenta usada tiver outra convenção, adapte apenas `lib.sh`.

## Ligando à ferramenta

A configuração de hooks é específica de cada ferramenta. Os scripts ficam aqui, versionados em um lugar só, e a configuração da ferramenta apenas os chama. Exemplo pronto para Claude Code em [`examples/claude-code-settings.json`](examples/claude-code-settings.json) — copie o conteúdo para `.claude/settings.json`. Para outras ferramentas, mapeie os mesmos eventos:

| Evento | Script |
| --- | --- |
| Início de sessão | `session-start.sh` |
| Antes de executar comando | `guard-command.sh` |
| Antes de escrever arquivo | `guard-files.sh` |
| Depois de escrever arquivo | `post-edit.sh` |
| Fim da resposta / fim da tarefa | `check-progress.sh` |

## Testando um hook

```sh
printf '{"tool_input":{"command":"git commit -m teste"}}' | sh .agents/hooks/guard-command.sh; echo "saída: $?"
# BLOQUEADO pelo hook: commits, push, merge, rebase, tags e reverts são feitos pelo humano. ...
# saída: 2
```
