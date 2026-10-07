# AGENTS.md

> Porta de entrada para qualquer agente de IA que trabalhe neste repositório.
> Leia este arquivo inteiro antes de agir. Ele é curto de propósito: aponta para onde está cada coisa.

## 1. Projeto

**Nome:** {{NOME_DO_PROJETO}}
**Objetivo em uma frase:** {{O_QUE_O_PROJETO_RESOLVE_E_PARA_QUEM}}
**Idioma da documentação:** Português do Brasil
**Idioma do código (identificadores, commits):** {{IDIOMA}}

## 2. Antes de começar qualquer tarefa

1. Leia [`docs/progress/STATUS.md`](docs/progress/STATUS.md) — estado atual, o que está em andamento e o que vem a seguir.
2. Leia [`docs/progress/lessons-learned.md`](docs/progress/lessons-learned.md) — erros que não devem se repetir.
3. **Classifique o pedido** na tabela da seção 3 e siga o roteiro indicado.
4. Leia as rules em [`.agents/rules/`](.agents/rules/) que se aplicam ao que você vai tocar (`00-core.md` sempre).
5. Se for trabalhar dentro de uma pasta que tem um `AGENTS.md` próprio, leia-o também: ele traz o contexto local daquele módulo e prevalece sobre este arquivo naquele escopo.

## 3. Roteiro por tipo de pedido

Todo pedido se encaixa em uma linha abaixo. Siga a skill indicada do início ao fim, **incluindo a seção "Fechamento"**, que diz o que registrar e onde.

| Pedido | Siga | Registro obrigatório | Termina quando |
| --- | --- | --- | --- |
| Ideia ou funcionalidade nova, ainda sem spec | skills `write-prd` → `write-spec` → `spec-to-tasks` | `docs/product/`, `docs/specs/`, `tasks/` | Tickets aprovados pelo humano |
| Implementar ticket ou funcionalidade especificada | skill `execute-task` | ticket, sessão, `STATUS.md`, `CHANGELOG.md` | Definition of Done atendida |
| Corrigir bug | skill `fix-bug` | ticket de bug, sessão, `CHANGELOG.md` | Teste de regressão passando e causa raiz registrada |
| Revisar código, PR ou branch | skill `review-code` | `docs/reports/reviews/` | Relatório gravado e humano decidiu o que corrigir |
| Checkup, auditoria, "ver como está" o projeto ou uma área | skill `health-check` | `docs/reports/checkups/` | Relatório gravado e problemas viraram tickets ou débitos |
| Refatorar ou melhorar código sem mudar comportamento | skill `refactor` | sessão, `STATUS.md` | Comportamento idêntico e testes verdes |
| Investigar, comparar opções, estudar viabilidade | skill `investigate` | `docs/reports/investigations/` | Recomendação entregue; ADR se houve decisão |
| Atualizar ou adicionar dependências | skill `update-dependencies` | `CHANGELOG.md`, sessão | Testes verdes após cada lote |
| Incidente em produção | skill `handle-incident` | `docs/operations/postmortems/` | Serviço estável e postmortem escrito |
| Registrar uma decisão | skill `record-decision` | `docs/decisions/` | ADR com status definido |
| Mensagem de commit, descrição de PR, notas de release | skill `prepare-commit` | nenhum (texto na resposta) | Proposta entregue; **o humano commita e abre o PR** |
| Fazer commit, push, merge ou abrir PR | **não execute** — entregue a proposta com `prepare-commit` | — | Humano executa |
| Alterar apenas documentação | rule `documentation.md` | o próprio documento | Links e índices consistentes |
| Encerrar a sessão / salvar progresso | skill `update-progress` | `docs/progress/` | Próximo passo claro no `STATUS.md` |
| Pergunta ou explicação | responda citando `arquivo:linha` | nenhum | Resposta dada. Se revelou lacuna nos docs, aponte-a |
| Não se encaixa em nenhuma linha | classifique pela linha mais próxima e confirme com o humano | — | — |

**Todo pedido que alterou arquivos** termina com a [Definition of Done](docs/process/definition-of-done.md) e uma resposta final contendo: o que foi feito, o que foi verificado (e como), o que ficou pendente, onde ficou registrado e a **proposta de commits** para o humano executar.

## 4. Comandos do projeto

| Ação | Comando |
| --- | --- |
| Instalar dependências | `{{COMANDO}}` |
| Rodar localmente | `{{COMANDO}}` |
| Testes | `{{COMANDO}}` |
| Lint | `{{COMANDO}}` |
| Formatação | `{{COMANDO}}` |
| Build | `{{COMANDO}}` |
| Listar dependências desatualizadas / vulneráveis | `{{COMANDO}}` |

Preparação do ambiente do zero e variáveis de ambiente: [`docs/setup.md`](docs/setup.md).

## 5. Hierarquia das fontes de verdade

Quando dois documentos discordarem, vale o de cima:

1. `docs/decisions/` — decisões registradas (ADRs aceitos)
2. `docs/product/prd.md` — o que o produto deve fazer
3. `docs/architecture/contracts.md` e `domain-model.md` — contratos e regras do domínio
4. `docs/specs/` — como cada etapa será construída
5. `tasks/` — fatias executáveis das specs
6. Código existente

Se encontrar uma divergência, **não escolha sozinho**: aponte-a ao humano e registre em `STATUS.md` na seção de bloqueios.

## 6. Regras de ouro

- **Você nunca faz commit, push, merge, rebase, tag, nem cria ou mescla pull requests.** Isso é responsabilidade exclusiva do humano. Você prepara as mensagens e descrições (skill `prepare-commit`). Ver [`.agents/rules/git-workflow.md`](.agents/rules/git-workflow.md).
- Não invente requisito. Se faltar informação, pergunte.
- Mudança de comportamento sem teste não está pronta.
- Toda decisão não trivial vira um ADR (skill `record-decision`).
- Nunca escreva segredos, credenciais ou dados reais de usuários em arquivos do repositório.
- Siga [`docs/architecture/conventions.md`](docs/architecture/conventions.md). Se um padrão precisar mudar, mude o documento junto com o código, nunca só o código.
- Nada que você verificou ou decidiu fica só no chat: vai para o registro indicado na seção 3.

## 7. Mapa do repositório

| Caminho | Para que serve |
| --- | --- |
| `.agents/rules/` | Regras persistentes de comportamento e padrão de código |
| `.agents/skills/` | Roteiros de cada tipo de atividade, carregados sob demanda |
| `.agents/agents/` | Subagentes especializados (planejador, revisor, auditor de docs) |
| `.agents/commands/` | Atalhos que o humano dispara (`/start-session`, `/new-feature`...) |
| `.agents/hooks/` | Scripts executados automaticamente em eventos do agente |
| `.agents/mcp/` | Servidores MCP (ferramentas externas) usados pelo projeto |
| `.agents/templates/` | Modelos: `AGENTS.md` de módulo e descrição de pull request |
| `docs/setup.md` | Como preparar o ambiente e o que é cada variável de ambiente |
| `docs/product/` | PRD, user stories e registro de decisões de produto |
| `docs/architecture/` | Visão geral, modelo de domínio, contratos e convenções de código |
| `docs/decisions/` | ADRs — por que cada decisão foi tomada |
| `docs/specs/` | Especificações de cada etapa de entrega |
| `docs/process/` | Definition of Ready e Definition of Done |
| `docs/reports/` | Relatórios de reviews, checkups e investigações |
| `docs/operations/` | Runbook e postmortems |
| `docs/progress/` | Estado atual, diário de sessões e lições aprendidas |
| `docs/glossary.md` | Linguagem do domínio |
| `tasks/` | Tickets (funcionalidades e bugs) com dependências |
| `CHANGELOG.md` | O que mudou em cada versão |
