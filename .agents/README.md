# .agents/

Configuração de **como os agentes trabalham**. Fonte única: as ferramentas de IA apontam para cá.

| Pasta | Conceito | Quando entra em ação |
| --- | --- | --- |
| `rules/` | Regras persistentes | `core.md` sempre; `code.md` ao tocar código |
| `skills/` | Roteiros de atividade, um `.md` por skill | Sob demanda, quando o pedido casa com o `AGENTS.md` §4 |
| `agents/` | Subagentes | Quando uma skill delega (revisão independente, auditoria de docs) |
| `hooks/` | Scripts automáticos | Executados pela ferramenta em eventos: início da sessão, antes de comando/edição, depois de edição |

## Ligando à ferramenta

| Ferramenta | Como ligar |
| --- | --- |
| Claude Code | `CLAUDE.md` já importa `AGENTS.md` e `rules/core.md`. Crie links `.claude/commands` → `.agents/skills` (as skills viram os comandos `/plan`, `/build`, `/fix`...) e `.claude/agents` → `.agents/agents`. Hooks: `hooks/examples/claude-code-settings.json` → `.claude/settings.json`. |
| Codex, Cursor, Copilot, Gemini CLI, Windsurf e outras | Leem `AGENTS.md` automaticamente, e ele aponta para todo o resto. Se a ferramenta tiver pastas próprias de rules/skills/hooks, ligue-as às daqui. |

Comandos de link para cada sistema operacional estão no `README.md` do backbone.

## Modelos

| Trabalho | Modelo | Por quê |
| --- | --- | --- |
| `plan`, decisões, investigação | {{modelo de maior raciocínio}} | Erros aqui se propagam |
| `build`, `fix` com spec clara | {{modelo rápido}} | A spec já reduziu a ambiguidade |
| `review` / subagente `reviewer` | {{modelo diferente do que implementou}} | Outro viés encontra mais problemas |
| Nível Rápido | {{modelo pequeno}} | Custo e velocidade |

## Servidores MCP

MCP adiciona tools externas ao agente (banco, navegador, rastreador de issues, documentação de bibliotecas). Registre aqui antes de configurar na ferramenta. Prefira acesso somente leitura; credenciais só por variável de ambiente.

| Servidor | Finalidade | Acesso | Variável de credencial | Responsável |
| --- | --- | --- | --- | --- |
| | | leitura / escrita | | |

## Skills de terceiros

Boas práticas de tecnologias específicas podem ser instaladas com `npx skills add <org>/<repo>`. Elas vêm no formato padrão de pasta (`nome/SKILL.md`), que as ferramentas descobrem sozinhas; deixe-as nesse formato. O `skills-lock.json` gerado na raiz deve ser versionado. Para que o agente as use também pelo roteiro, acrescente uma linha no `AGENTS.md` §4 apontando para o `SKILL.md` delas.
