# .agents/

Tudo que configura **como os agentes de IA trabalham** neste projeto. Fica separado de `docs/` porque aqui não se descreve o produto: descreve-se o processo.

| Pasta | Conceito | Quando é carregado |
| --- | --- | --- |
| `rules/` | Rules | Sempre, ou automaticamente quando o agente toca arquivos que casam com `applies_to` |
| `skills/` | Skills | Sob demanda: o agente vê só `name` + `description` e carrega o resto quando o pedido casa — reforçado pelo roteiro da seção 3 do `AGENTS.md` |
| `agents/` | Subagents | Quando o agente principal delega uma tarefa isolada |
| `commands/` | Commands / prompts reutilizáveis | Quando o humano dispara explicitamente (`/nome`) |
| `hooks/` | Hooks | Automaticamente, executados pela ferramenta em eventos do ciclo do agente |
| `mcp/` | MCP (tools externas) | Quando o agente precisa de uma ferramenta que não é nativa |
| `templates/` | Modelos | Ao criar arquivos de configuração de agentes, como o `AGENTS.md` de um módulo |
| `models.md` | Matriz de modelos | Consulta humana: qual modelo usar para cada tipo de trabalho |

## Ligando às ferramentas

Esta pasta é a **fonte única**. Cada ferramenta lê de um lugar diferente; aponte-as para cá com um link simbólico ou cópia, em vez de manter versões paralelas:

| Ferramenta | Onde ela procura | Como ligar |
| --- | --- | --- |
| Claude Code | `CLAUDE.md`, `.claude/skills/`, `.claude/agents/`, `.claude/commands/`, `.claude/settings.json` (hooks), `.mcp.json` | `CLAUDE.md` já importa `AGENTS.md`; crie links de `.claude/skills` → `.agents/skills` etc.; hooks em `hooks/examples/claude-code-settings.json` |
| Codex, Cursor, Copilot, Gemini CLI, Windsurf e outros | `AGENTS.md` (padrão aberto) + pastas próprias de rules/skills/hooks | Leem `AGENTS.md` diretamente; para rules específicas, ligue `.cursor/rules` → `.agents/rules` ou equivalente; mapeie os eventos de hook conforme `hooks/README.md` |
| CLI `npx skills` | `.agents/skills/` + `skills-lock.json` | Funciona sem adaptação |

Mesmo numa ferramenta que não suporte skills, subagentes ou hooks, o backbone funciona: o `AGENTS.md` é lido por todas, e o roteiro da seção 3 aponta para os arquivos que o agente deve abrir.

Para skills de terceiros (ex.: boas práticas de uma tecnologia), instale com o gerenciador de skills. Ele grava a origem e o hash em `skills-lock.json` na raiz, que deve ser versionado para que todo o time use a mesma versão.
