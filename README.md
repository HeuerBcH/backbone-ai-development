# backbone-ai-development

Estrutura base de pastas e documentos para desenvolver projetos com agentes de IA de forma **rastreável, padronizada e auditável**. Você copia para a raiz de um projeto novo, segue o guia abaixo e, a partir daí, qualquer agente de IA que abrir o projeto sabe o que é o projeto, onde ele está, quais padrões seguir, como executar cada tipo de pedido e onde registrar o que fez.

Ele resolve os quatro problemas mais comuns do desenvolvimento com IA:

1. **Amnésia:** o agente não lembra da sessão anterior → `docs/progress/` guarda o estado e o histórico.
2. **Suposição:** sem contexto, o agente inventa → `docs/product/`, `docs/architecture/`, `docs/specs/` e `tasks/` definem o que fazer antes de fazer.
3. **Inconsistência:** cada sessão escreve de um jeito → `.agents/rules/` e `docs/architecture/conventions.md` fixam os padrões.
4. **Improviso:** cada pedido é executado de um jeito e o resultado some no chat → o roteiro do `AGENTS.md` liga cada tipo de pedido a uma skill com passos e fechamento definidos.

---

## Sumário

**Para usar**

1. [Guia rápido](#guia-rápido)
2. [Passo a passo: configurar um projeto novo](#passo-a-passo-configurar-um-projeto-novo)
3. [Checklist de preenchimento](#checklist-de-preenchimento)
4. [Uso no dia a dia](#uso-no-dia-a-dia)
5. [O que é seu e o que é da IA](#o-que-é-seu-e-o-que-é-da-ia)

**Para entender**

6. [Conceitos](#conceitos)
7. [Como a IA sabe o que fazer em cada pedido](#como-a-ia-sabe-o-que-fazer-em-cada-pedido)
8. [Padrões de desenvolvimento: onde ficam e por quê](#padrões-de-desenvolvimento-onde-ficam-e-por-quê)
9. [Estrutura](#estrutura)
10. [O que é cada pasta e arquivo](#o-que-é-cada-pasta-e-arquivo)
11. [Fluxo de trabalho](#fluxo-de-trabalho)
12. [Manutenção do backbone](#manutenção-do-backbone)

---

## Guia rápido

Para quem já leu o guia completo uma vez:

1. Copie o backbone para o projeto (sem `.git/` e sem este `README.md`).
2. Preencha a seção 1 do `AGENTS.md`.
3. Ligue `.agents/` à sua ferramenta de IA e ative os hooks.
4. Peça à IA para definir o produto (`/new-feature` ou "quero definir o produto").
5. Registre a escolha de tecnologias como ADR e preencha `conventions.md`, `setup.md` e os comandos do `AGENTS.md`.
6. Gere specs e tickets, e comece: `/start-session 01`.
7. Ao fim de cada sessão: `/end-session` → revise → **você** commita.

---

## Passo a passo: configurar um projeto novo

### Passo 0 — Pré-requisitos

- **Git** instalado.
- **Shell POSIX** para os hooks (`sh`): nativo em Linux e macOS; no Windows, use o Git Bash (vem com o Git) ou o WSL.
- Uma **ferramenta de IA com agente** (Claude Code, Codex, Cursor, Copilot, Gemini CLI, Windsurf etc.).

### Passo 1 — Copiar o backbone para o projeto

Na pasta do projeto novo (vazia ou já existente):

```sh
# Linux / macOS / Git Bash — copia tudo, inclusive arquivos ocultos, exceto .git/ e README.md
tar -C /caminho/backbone-ai-development --exclude=./.git --exclude=./README.md -cf - . | tar -xf -
```

```powershell
# Windows PowerShell — mesmo resultado
Get-ChildItem -Force C:\caminho\backbone-ai-development |
  Where-Object { $_.Name -notin '.git', 'README.md' } |
  Copy-Item -Destination . -Recurse -Force
```

A pasta `.git/` do backbone fica de fora porque o projeto tem o próprio repositório. Depois, crie o `README.md` do projeto (o que ele é e como rodar, apontando para `docs/setup.md`).

Confira o `.gitignore` do projeto: ele precisa ignorar `.env` e `.env.*`, mantendo `.env.example` versionado, e também os arquivos `*.local.*` de configuração pessoal das ferramentas de IA.

### Passo 2 — Identidade do projeto (`AGENTS.md`)

Abra o `AGENTS.md` e preencha:

- **Seção 1:** nome, objetivo em uma frase, idioma da documentação e idioma do código.
- **Seção 4 (comandos):** deixe os `{{COMANDO}}` por enquanto se as tecnologias ainda não foram escolhidas. Preencha no Passo 7.

O resto do `AGENTS.md` (roteiro, hierarquia, regras de ouro, mapa) já vem pronto.

### Passo 3 — Ligar à ferramenta de IA

`.agents/` é a fonte única; cada ferramenta lê de um lugar diferente.

**Claude Code**

- `CLAUDE.md` já importa o `AGENTS.md` e as rules sempre ativas. Nada a fazer.
- Skills, subagentes e commands: crie links das pastas da ferramenta para `.agents/`:

  ```sh
  # Linux / macOS
  mkdir -p .claude
  ln -s ../.agents/skills   .claude/skills
  ln -s ../.agents/agents   .claude/agents
  ln -s ../.agents/commands .claude/commands
  ```

  ```powershell
  # Windows PowerShell (junction não exige administrador)
  New-Item -ItemType Directory -Force .claude | Out-Null
  New-Item -ItemType Junction -Path .claude\skills   -Target .agents\skills
  New-Item -ItemType Junction -Path .claude\agents   -Target .agents\agents
  New-Item -ItemType Junction -Path .claude\commands -Target .agents\commands
  ```

  Se o time usa sistemas operacionais diferentes, adicione `.claude/skills`, `.claude/agents` e `.claude/commands` ao `.gitignore` e cada pessoa cria os links ao clonar.
- Subagentes: no frontmatter dos arquivos de `.agents/agents/`, troque `tools: [read, search, bash]` pelos nomes da ferramenta (ex.: `tools: Read, Grep, Glob, Bash`) ou remova a linha para herdar todas.
- Hooks: copie o conteúdo de `.agents/hooks/examples/claude-code-settings.json` para `.claude/settings.json`.
- MCP: configure em `.mcp.json` os servidores registrados em `.agents/mcp/servers.md`.

**Outras ferramentas (Codex, Cursor, Copilot, Gemini CLI, Windsurf...)**

- Todas leem o `AGENTS.md` automaticamente, e ele aponta para todo o resto. Só isso já faz o backbone funcionar.
- Se a ferramenta tiver pasta própria de rules, skills ou commands, ligue-a à pasta correspondente de `.agents/` (como acima) ou converta o frontmatter para o formato dela (ex.: `applies_to` → `globs`, `always_apply` → `alwaysApply`).
- Hooks: mapeie os eventos da ferramenta para os scripts, conforme a tabela em `.agents/hooks/README.md`.

### Passo 4 — Ativar e testar os hooks

1. Em `.agents/hooks/post-edit.sh`, deixe `FORMAT_CMD` e `LINT_CMD` vazios por enquanto. Preencha no Passo 7, quando as tecnologias estiverem definidas.
2. Teste o bloqueio de commit pela IA:

   ```sh
   printf '{"tool_input":{"command":"git commit -m teste"}}' | sh .agents/hooks/guard-command.sh; echo "saída: $?"
   # esperado: mensagem "BLOQUEADO pelo hook..." e saída: 2
   ```

3. Abra uma sessão na ferramenta de IA: o hook `session-start.sh` deve mostrar o conteúdo do `STATUS.md`.

### Passo 5 — Primeiro registro

- `docs/decisions/0001-documentacao-orientada-a-agentes.md` e `docs/decisions/README.md`: preencha data e decisores.
- `docs/progress/STATUS.md`: data de hoje, fase **descoberta**, próximo passo "Definir o produto (PRD)".

### Passo 6 — Definir o produto

Peça à IA: `/new-feature <descrição da ideia>` ou "quero definir o produto". Ela vai seguir a skill `write-prd`:

- entrevista com uma pergunta por vez;
- decisões datadas em `docs/product/decisions-log.md`;
- `prd.md`, `user-stories.md`, `glossary.md` e um esboço de `domain-model.md`.

Revise tudo. O PRD é a base de todo o resto.

### Passo 7 — Escolher as tecnologias e fixar os padrões

Peça à IA para investigar as opções (skill `investigate`) e registre cada escolha como ADR (skill `record-decision`). Com as tecnologias decididas, preencha:

| Arquivo | O que preencher |
| --- | --- |
| `docs/architecture/conventions.md` | Todos os campos `{{...}}`: caixa de nomes por elemento, camadas, patterns adotados, formato de erros, ferramentas de teste, logs |
| `AGENTS.md` §4 | Comandos de instalar, rodar, testar, lint, formatar, build e auditar dependências |
| `.agents/hooks/post-edit.sh` | `FORMAT_CMD` e `LINT_CMD` |
| `docs/setup.md` + `.env.example` | Pré-requisitos, primeira execução, variáveis de ambiente |
| `docs/architecture/overview.md` | Componentes, estrutura de pastas, ambientes |
| `.agents/rules/*.md` | Opcional: restrinja `applies_to` às pastas reais do código |
| `.agents/models.md` | Qual modelo usar para cada tipo de trabalho |
| `.agents/mcp/servers.md` | Servidores MCP que o projeto vai usar |

Skills de boas práticas das tecnologias escolhidas podem ser instaladas em `.agents/skills/` (ex.: `npx skills add <org>/<repo>`), gerando o `skills-lock.json`.

### Passo 8 — Specs e tickets

- Skill `write-spec`: uma spec por etapa entregável em `docs/specs/`, com `contracts.md` e `domain-model.md` atualizados.
- Skill `spec-to-tasks`: tickets de fatia vertical em `tasks/`, com o quadro de dependências em `tasks/README.md`.

### Passo 9 — Primeiro commit (seu)

Peça `/commit-msg`. A IA entrega os commits agrupados e as mensagens prontas. **Você** revisa, commita e publica. A partir daqui, siga o [uso no dia a dia](#uso-no-dia-a-dia).

---

## Checklist de preenchimento

| Arquivo | O que preencher | Quando |
| --- | --- | --- |
| `AGENTS.md` §1 | Nome, objetivo, idiomas | Passo 2 |
| `.gitignore` do projeto | `.env`, `.env.*` (exceto `.env.example`), `*.local.*` | Passo 1 |
| Ferramenta de IA | Links, `settings.json`/hooks, MCP | Passo 3 |
| `docs/decisions/0001-*` e `README.md` | Data e decisores | Passo 5 |
| `docs/progress/STATUS.md` | Data, fase, próximo passo | Passo 5 e sempre |
| `docs/product/*` e `docs/glossary.md` | PRD, stories, decisões, termos | Passo 6 (skill `write-prd`) |
| `docs/architecture/domain-model.md` | Entidades, estados, invariantes | Passos 6 e 8 |
| `docs/architecture/conventions.md` | Decisões do projeto `{{...}}` | Passo 7 |
| `AGENTS.md` §4 | Comandos | Passo 7 |
| `.agents/hooks/post-edit.sh` | `FORMAT_CMD`, `LINT_CMD` | Passo 7 |
| `docs/setup.md` e `.env.example` | Ambiente e variáveis | Passo 7 e sempre que mudar |
| `docs/architecture/overview.md` | Componentes e estrutura | Passo 7 e sempre que mudar |
| `.agents/models.md`, `.agents/mcp/servers.md` | Modelos e servidores MCP | Passo 7 |
| `docs/architecture/contracts.md` | Interfaces públicas | Passo 8 e sempre que mudar |
| `docs/specs/`, `tasks/` | Specs e tickets | Passo 8 (skills) |
| `docs/operations/runbook.md` | Implantação, rollback, saúde | Antes do primeiro deploy |

---

## Uso no dia a dia

Você pode usar os commands (`/nome`) ou pedir em linguagem natural: o roteiro do `AGENTS.md` leva à mesma skill.

| Você quer... | Digite ou diga | O que a IA faz | Onde fica registrado |
| --- | --- | --- | --- |
| Começar a trabalhar | `/start-session [ticket]` | Lê o estado, confere o Git e propõe o próximo passo | — |
| Uma funcionalidade nova | `/new-feature <ideia>` | PRD → spec → tickets, sem implementar | `docs/product/`, `docs/specs/`, `tasks/` |
| Implementar um ticket | "implementa o ticket 03" | Planeja, testa, implementa, revisa, documenta | ticket, sessão, `STATUS.md`, `CHANGELOG.md` |
| Corrigir um bug | `/fix <descrição>` | Reproduz, teste que falha, causa raiz, correção | ticket de bug, `CHANGELOG.md` |
| Uma revisão | `/review [branch]` | Revisa e lista achados por severidade | `docs/reports/reviews/` |
| Um checkup | `/checkup [área]` | Diagnóstico com evidência em até 9 dimensões | `docs/reports/checkups/` |
| Refatorar | "refatora X" | Passos pequenos com testes verdes | sessão |
| Pesquisar ou comparar | "investiga X vs Y" | Alternativas, fontes, recomendação | `docs/reports/investigations/` |
| Atualizar dependências | "atualiza as dependências" | Lotes pequenos e testados | `CHANGELOG.md`, sessão |
| Resolver um incidente | "produção caiu" | Estabiliza, corrige, escreve postmortem | `docs/operations/postmortems/` |
| Registrar uma decisão | "decidimos usar X" | Cria ADR | `docs/decisions/` |
| Mensagens de commit / PR | `/commit-msg [pr]` | Agrupa arquivos e escreve as mensagens | — (texto para você) |
| Verificar a documentação | `/audit-docs` | Compara docs com o código | correções aprovadas |
| Encerrar | `/end-session` | Registra a sessão, atualiza o estado e prepara os commits | `docs/progress/` |

**Rotina de uma sessão:**

```
/start-session  →  pedido(s)  →  /end-session  →  você revisa o diff  →  você commita, faz push e abre o PR
```

**Manutenção periódica:** `/checkup` e `/audit-docs` a cada entrega ou a cada poucas semanas.

---

## O que é seu e o que é da IA

| Responsabilidade | Humano | IA |
| --- | --- | --- |
| Decidir requisitos, prioridades e aprovar specs | ✅ | Propõe e pergunta |
| Aceitar ADRs | ✅ | Escreve como `proposto` |
| Implementar, testar, revisar, documentar | Revisa | ✅ |
| Criar branch local | ✅ | ✅ |
| `git add`, `commit`, `push`, `merge`, `rebase`, `tag` | ✅ **exclusivo** | ❌ bloqueado por rule e hook |
| Criar, aprovar e mesclar PR; criar release | ✅ **exclusivo** | ❌ bloqueado por rule e hook |
| Mensagens de commit, descrição de PR, notas de release | Revisa e usa | ✅ prepara (skill `prepare-commit`) |
| Ações em produção, apagar dados | ✅ **exclusivo** | Prepara o comando e pede confirmação |
| Editar `.env` e segredos | ✅ **exclusivo** | ❌ bloqueado por hook |

**Por que commits e PRs são do humano:** o commit é o registro auditável de quem aprovou cada mudança. Quem assina precisa ser quem revisou e decidiu publicar. A regra está em três camadas: `AGENTS.md` (regras de ouro), `.agents/rules/git-workflow.md` (sempre ativa) e o hook `guard-command.sh`, que bloqueia os comandos mesmo que o modelo esqueça a regra.

---

## Conceitos

### Contexto e engenharia de contexto

Um modelo de linguagem só sabe o que está na janela de contexto naquele momento: o prompt, os arquivos que leu, as respostas das tools. **Engenharia de contexto** é decidir *o que* entra nessa janela, *quando* e *em que formato*. Tudo neste backbone é engenharia de contexto: alguns arquivos entram sempre (`AGENTS.md`, rules globais, saída do hook de início de sessão), outros só quando necessários (skills, specs, rules por glob), e outros rodam em contexto separado (subagentes).

Mais contexto não é melhor. Contexto irrelevante dilui a atenção do modelo e custa dinheiro. Por isso a estrutura é em camadas.

### Prompt

A instrução que você dá. Um bom prompt de desenvolvimento diz **o objetivo, o contexto, as restrições e o formato da saída**. Prompts que você repete viram **commands**; procedimentos que você explica repetidamente viram **skills**; regras que você corrige repetidamente viram **rules**; verificações que não podem falhar viram **hooks**.

### AGENTS.md (arquivo de instruções do projeto)

Arquivo na raiz que o agente lê automaticamente ao abrir o projeto. É um padrão aberto suportado pela maioria das ferramentas (cada uma também tem seu nome próprio, como `CLAUDE.md`, que aqui importa o `AGENTS.md` e as rules sempre ativas). Funciona como o "onboarding" do agente: o que é o projeto, **qual roteiro seguir para cada tipo de pedido**, comandos, regras de ouro e mapa do repositório. Deve ser curto e **apontar** para os documentos detalhados em vez de repeti-los.

Em projetos grandes, módulos podem ter seu próprio `AGENTS.md` com o contexto local (modelo em `.agents/templates/AGENTS.module.md`); o agente lê o da raiz e o da pasta em que está trabalhando.

### Rules

Instruções **persistentes**, carregadas sempre ou automaticamente quando o agente mexe em determinados arquivos. Definem *como as coisas devem ser*: estilo de código, design, testes, segurança, Git. São a forma de não precisar repetir "não esqueça de..." toda vez. Boas rules são curtas, verificáveis e explicam o porquê.

### Skills

Pacotes de conhecimento procedural (**como executar uma atividade**) que o agente carrega **sob demanda**. O agente vê apenas o nome e a descrição de cada skill; quando o pedido casa com a descrição, ele lê o `SKILL.md` e, se precisar, os arquivos de apoio (`references/`, `scripts/`, `templates/`). Isso se chama *progressive disclosure* e permite ter muitas skills sem gastar contexto.

Neste backbone, toda skill tem as mesmas seções: quando usar, passos, **boas práticas da atividade** e **fechamento** (o que registrar, onde, o que atualizar e o que responder).

No repositório de inspiração (`vDev-quest`) aparecem três skills de terceiros: uma de design de frontend, uma de boas práticas de React e uma de PostgreSQL. A de React mostra o formato avançado: o `SKILL.md` é um índice de 70 regras separadas por prefixo e prioridade, e cada regra é um arquivo em `rules/` com exemplo correto e incorreto. O agente só abre a regra que precisa. O `skills-lock.json` registra de onde cada skill veio e seu hash, como um lockfile de dependências.

### Tools

As **ações** que o agente pode executar: ler e editar arquivos, buscar no código, rodar comandos no terminal, pesquisar na web. É o que transforma um chat em um agente. Sem tools o modelo só escreve texto; com tools ele age, observa o resultado e decide o próximo passo (o *loop agêntico*).

### MCP (Model Context Protocol)

Protocolo aberto para **adicionar tools novas** a qualquer agente compatível. Um servidor MCP expõe ferramentas (ex.: consultar o banco, abrir issues, controlar um navegador, ler documentação atualizada de uma biblioteca) e o agente passa a usá-las como se fossem nativas. O mesmo servidor funciona em várias ferramentas de IA.

### Subagents

Agentes especializados que o agente principal **delega** para uma tarefa isolada. Rodam em contexto próprio, podem ter tools e modelo diferentes e devolvem só o resultado. Servem para manter o contexto principal limpo (uma revisão que lê 40 arquivos não polui a sessão), para especializar (revisor, planejador, auditor) e para obter um olhar independente.

### Commands (slash commands / workflows)

Prompts salvos que **o humano dispara pelo nome** (`/review`). São atalhos: pedir em linguagem natural leva à mesma skill pelo roteiro do `AGENTS.md`.

### Hooks

Scripts que a **ferramenta** executa automaticamente em eventos do ciclo do agente (início da sessão, antes de um comando, depois de editar um arquivo, fim da resposta). Diferente de rules e skills, que são pedidos ao modelo e podem ser esquecidos, hooks são **determinísticos**. Este backbone traz scripts prontos que bloqueiam commits/PRs e comandos destrutivos, protegem arquivos de segredo, formatam e verificam arquivos editados, injetam o estado do projeto no início da sessão e cobram o registro de progresso.

### Memória

O agente não lembra de nada entre sessões. A memória do projeto é **escrita em arquivos**: `STATUS.md` (estado atual), `sessions/` (diário), `lessons-learned.md` (erros a não repetir), `decisions/` (por que as coisas são assim) e `reports/` (o que já foi verificado). Algumas ferramentas têm memória própria; a do repositório tem a vantagem de ser versionada, revisável e compartilhada com o time.

### Spec-driven development

Fluxo em que **nada é implementado antes de estar especificado**: ideia → PRD → user stories → spec → tickets → código. Cada etapa reduz a ambiguidade da seguinte. É o que permite entregar tickets a um agente (ou a um modelo mais barato) com alta taxa de acerto. O `vDev-quest` segue exatamente esse fluxo em `docs/` e `tasks/`.

### Definition of Ready / Definition of Done

Critérios únicos de "pode começar" e "está pronto", em um arquivo só. Sem eles, cada agente decide sozinho quando parar — e normalmente para cedo demais, sem testar ou sem documentar.

### ADR (Architecture Decision Record)

Documento curto que registra **uma decisão**: contexto, alternativas, escolha e consequências. ADRs aceitos não são editados; se a decisão mudar, um novo ADR substitui o anterior. O resultado é um histórico auditável do raciocínio do projeto.

### Modelos

Modelos diferentes têm custo, velocidade e capacidade de raciocínio diferentes. A prática recomendada é **planejar com o modelo mais capaz e executar com o mais rápido**, e revisar com um modelo diferente do que implementou. A escolha do time fica registrada em [`.agents/models.md`](.agents/models.md).

---

## Como a IA sabe o que fazer em cada pedido

A seção 3 do `AGENTS.md` é uma tabela de roteiro. Ela fica no `AGENTS.md`, e não numa rule, porque esse é o único arquivo que **toda** ferramenta carrega sempre. Funciona em três camadas:

1. **Classificação** — todo pedido cai em uma linha da tabela (implementar, corrigir bug, revisar, checkup, refatorar, investigar, atualizar dependências, incidente, decisão, commit/PR, documentação, encerrar sessão, pergunta). Se não se encaixar, o agente confirma com o humano.
2. **Execução** — cada linha aponta para uma skill com os passos e as boas práticas daquela atividade.
3. **Fechamento** — toda skill termina com a mesma estrutura:
   - **Registre:** onde o resultado fica gravado (relatório, ticket, sessão, ADR).
   - **Atualize:** quais documentos podem precisar mudar como consequência.
   - **Verifique:** quais critérios da Definition of Done se aplicam.
   - **Responda:** o que a mensagem final ao humano deve conter — sempre incluindo a proposta de commits quando arquivos mudaram.

Duas redes de segurança garantem que isso aconteça: a rule `documentation.md` (sempre ativa) diz "se você fez X, atualize Y", e o hook `check-progress.sh` cobra o registro quando há arquivos alterados sem atualização em `docs/progress/`.

---

## Padrões de desenvolvimento: onde ficam e por quê

Registrar padrões é necessário: é o que faz código escrito em sessões diferentes, por agentes diferentes, parecer escrito pela mesma pessoa. Mas a forma importa:

- **Princípios, não dogmas.** "Sempre use design patterns" gera abstração desnecessária; o padrão registrado é "use um pattern quando resolve um problema presente, e reutilize o já adotado para o mesmo problema". "Nunca comente código" esconde decisões; o padrão é "nunca deixe código comentado; comente o *porquê*, não o *quê*".
- **Universal vs. específico.** Princípios de nomenclatura (nomes que revelam intenção, booleanos como pergunta, unidade no nome) valem sempre e já vêm preenchidos. A **caixa** (camelCase, snake_case...) depende da linguagem: o backbone exige seguir a convenção idiomática e registrá-la em `conventions.md` §1, em vez de fixar uma.
- **Duas versões, sempre alinhadas.** `conventions.md` é a versão completa, com exemplos e as escolhas do projeto. As rules são a versão curta e imperativa para o agente.
- **Práticas por atividade ficam na skill.** Como revisar bem, como depurar, como refatorar com segurança: isso está na seção "Boas práticas" de cada skill, carregada só quando a atividade acontece.

| Tipo de padrão | Onde |
| --- | --- |
| Nomenclatura, funções, comentários, erros, logs | `.agents/rules/code-style.md` + `conventions.md` §1, §4, §5, §8 |
| Simplicidade, design patterns, SOLID, fronteiras | `.agents/rules/design.md` + `conventions.md` §2, §3 |
| Testes | `.agents/rules/testing.md` + `conventions.md` §7 |
| Git: o que é do humano, padrão de mensagens | `.agents/rules/git-workflow.md` |
| Segurança | `.agents/rules/security.md` |
| Documentação | `.agents/rules/documentation.md` |
| Anti-padrões proibidos | `conventions.md` §10 |
| Práticas de cada atividade | Seção "Boas práticas" de cada skill |
| Critérios de "pronto" | `docs/process/definition-of-done.md` |

---

## Estrutura

```
.
├── AGENTS.md                         # porta de entrada + roteiro por tipo de pedido
├── CLAUDE.md                         # adaptador: importa AGENTS.md e as rules sempre ativas
├── CHANGELOG.md                      # o que mudou em cada versão
├── .env.example                      # modelo das variáveis de ambiente (sem valores reais)
│
├── .agents/                          # COMO os agentes trabalham
│   ├── README.md                     # mapa da pasta e como ligar às ferramentas
│   ├── models.md                     # qual modelo usar para cada tipo de trabalho
│   ├── rules/                        # regras persistentes
│   │   ├── README.md
│   │   ├── 00-core.md
│   │   ├── documentation.md
│   │   ├── security.md
│   │   ├── git-workflow.md
│   │   ├── code-style.md
│   │   ├── design.md
│   │   └── testing.md
│   ├── skills/                       # roteiros de cada atividade
│   │   ├── README.md
│   │   ├── _template/SKILL.md
│   │   ├── write-prd/            ├── fix-bug/
│   │   ├── write-spec/           ├── review-code/
│   │   ├── spec-to-tasks/        ├── health-check/
│   │   ├── execute-task/         ├── refactor/
│   │   ├── record-decision/      ├── investigate/
│   │   ├── update-progress/      ├── update-dependencies/
│   │   ├── prepare-commit/       └── handle-incident/
│   ├── agents/                       # subagentes especializados
│   │   ├── README.md
│   │   ├── _template.md
│   │   ├── planner.md
│   │   ├── code-reviewer.md
│   │   └── doc-auditor.md
│   ├── commands/                     # atalhos disparados pelo humano
│   │   ├── README.md
│   │   ├── start-session.md      ├── fix.md
│   │   ├── end-session.md        ├── review.md
│   │   ├── new-feature.md        ├── checkup.md
│   │   ├── commit-msg.md         └── audit-docs.md
│   ├── hooks/                        # automações determinísticas
│   │   ├── README.md
│   │   ├── lib.sh
│   │   ├── session-start.sh
│   │   ├── guard-command.sh
│   │   ├── guard-files.sh
│   │   ├── post-edit.sh
│   │   ├── check-progress.sh
│   │   └── examples/claude-code-settings.json
│   ├── mcp/
│   │   ├── README.md
│   │   └── servers.md
│   └── templates/
│       ├── AGENTS.module.md          # AGENTS.md local para módulos
│       └── pull-request.md           # modelo de descrição de PR
│
├── docs/                             # O QUE o projeto é e ONDE ele está
│   ├── README.md                     # índice, ordem de leitura e fluxo de documentos
│   ├── glossary.md
│   ├── setup.md                      # ambiente do zero e variáveis de ambiente
│   ├── product/
│   │   ├── prd.md
│   │   ├── user-stories.md
│   │   └── decisions-log.md
│   ├── architecture/
│   │   ├── overview.md
│   │   ├── domain-model.md           # entidades, estados, invariantes
│   │   ├── contracts.md              # interfaces públicas expostas e consumidas
│   │   └── conventions.md            # padrões de código e design patterns
│   ├── decisions/
│   │   ├── README.md
│   │   ├── 0000-template.md
│   │   └── 0001-documentacao-orientada-a-agentes.md
│   ├── specs/
│   │   ├── README.md
│   │   └── _template.md
│   ├── process/
│   │   └── definition-of-done.md     # Definition of Ready + Done
│   ├── reports/
│   │   ├── README.md                 # índice de relatórios
│   │   ├── reviews/_template.md
│   │   ├── checkups/_template.md
│   │   └── investigations/_template.md
│   ├── operations/
│   │   ├── runbook.md
│   │   └── postmortems/_template.md
│   └── progress/
│       ├── STATUS.md
│       ├── lessons-learned.md
│       └── sessions/_template.md
│
└── tasks/                            # tickets executáveis
    ├── README.md                     # quadro: ordem, bloqueios, fronteira
    ├── _template.md                  # funcionalidade
    └── _template-bug.md              # bug
```

A divisão principal é: **`.agents/` descreve o processo**, **`docs/` descreve o produto e seu estado**, **`tasks/` é o trabalho a fazer**.

---

## O que é cada pasta e arquivo

### Raiz

| Arquivo | Para que serve |
| --- | --- |
| `AGENTS.md` | Primeiro arquivo que qualquer agente lê. Identidade do projeto, o que ler antes de começar, **roteiro por tipo de pedido**, comandos, hierarquia das fontes de verdade, regras de ouro (incluindo "nunca commitar") e mapa do repositório. |
| `CLAUDE.md` | Adaptador para ferramentas que procuram um nome específico: importa o `AGENTS.md` e as rules sempre ativas, para existir uma única fonte de instruções. |
| `CHANGELOG.md` | O que foi adicionado, alterado, removido ou corrigido em cada versão, em linguagem de usuário. Segue *Keep a Changelog*. |
| `.env.example` | Lista de todas as variáveis de ambiente, sem valores reais. Copiado para `.env` na instalação. Documentado em `docs/setup.md`. |

### `.agents/` — processo de trabalho dos agentes

| Arquivo | Para que serve |
| --- | --- |
| `README.md` | Explica cada subpasta, quando cada coisa é carregada e como apontar as ferramentas de IA para esta pasta. |
| `models.md` | Matriz "tipo de trabalho → modelo/ferramenta → por quê". |
| `templates/AGENTS.module.md` | Modelo de `AGENTS.md` local para módulos, pacotes ou serviços com regras próprias. |
| `templates/pull-request.md` | Modelo de descrição de PR usado pela skill `prepare-commit`. |

#### `.agents/rules/`

| Arquivo | Para que serve |
| --- | --- |
| `README.md` | Formato das rules, boas práticas, e tabela de **onde fica cada tipo de boa prática**. |
| `00-core.md` | Comportamento base: ler o estado, classificar o pedido e seguir a skill até o fechamento, mudança mínima, perguntar em vez de supor, Definition of Done, nunca commitar. |
| `documentation.md` | Tabela "se você fez X, atualize Y" — cobre todos os documentos do backbone. |
| `security.md` | Segredos, dados reais, dependências, prompt injection e confirmação humana para ações destrutivas. |
| `git-workflow.md` | O que é exclusivo do humano (commit, push, merge, PR...), o que o agente pode fazer (ler, criar branch, preparar textos) e o padrão de branches, mensagens e PRs. |
| `code-style.md` | Nomenclatura, funções, comentários, erros, logs e formatação. |
| `design.md` | Simplicidade, uso criterioso de design patterns, SOLID, composição, fronteiras e acoplamento. |
| `testing.md` | O que é um bom teste, quando escrever e o que nunca fazer com um teste que falha. |

#### `.agents/skills/`

Todas seguem a estrutura: quando usar → passos → boas práticas → fechamento.

| Skill | Atividade | Registro principal |
| --- | --- | --- |
| `_template/` | Modelo para criar skills novas | — |
| `write-prd/` | Entrevista e escreve PRD, user stories, glossário e esboço do domínio | `docs/product/` |
| `write-spec/` | Spec de uma etapa com decisões de implementação e de teste | `docs/specs/` |
| `spec-to-tasks/` | Quebra a spec em tickets de fatia vertical | `tasks/` |
| `execute-task/` | Implementa um ticket de ponta a ponta | ticket + sessão |
| `fix-bug/` | Reproduz, escreve teste que falha, acha a causa raiz, corrige, varre o padrão | ticket de bug + CHANGELOG |
| `review-code/` | Revisa uma mudança e grava os achados | `docs/reports/reviews/` |
| `health-check/` | Checkup do projeto ou de uma área em 9 dimensões, com evidência | `docs/reports/checkups/` |
| `refactor/` | Melhora a estrutura em passos pequenos sem mudar comportamento | sessão |
| `investigate/` | Pesquisa, compara alternativas, prova de conceito, recomendação | `docs/reports/investigations/` |
| `update-dependencies/` | Atualiza em lotes testados; avalia dependências novas | CHANGELOG + sessão |
| `handle-incident/` | Estabiliza, registra a linha do tempo, corrige e escreve postmortem | `docs/operations/postmortems/` |
| `prepare-commit/` | Agrupa arquivos em commits e escreve mensagens, descrição de PR e notas de release **para o humano executar** | resposta |
| `record-decision/` | Cria ADR com alternativas e consequências | `docs/decisions/` |
| `update-progress/` | Registra a sessão e atualiza o `STATUS.md` | `docs/progress/` |

#### `.agents/agents/`

| Arquivo | Para que serve |
| --- | --- |
| `README.md` | O que são subagentes, por que usá-los e o formato do arquivo. |
| `_template.md` | Modelo para criar subagentes novos. |
| `planner.md` | Devolve um plano de implementação com riscos, testes e se precisa de ADR. |
| `code-reviewer.md` | Revisor cético: compara o diff com ticket, spec, contratos, domínio, convenções e rules; devolve achados com cenário concreto. |
| `doc-auditor.md` | Verifica se todos os documentos refletem o código e o estado real. |

#### `.agents/commands/`

| Arquivo | Para que serve |
| --- | --- |
| `README.md` | O que são commands e a diferença para skills. |
| `start-session.md` | Carrega contexto, confere o Git contra o `STATUS.md` e propõe o próximo passo. |
| `end-session.md` | Executa `update-progress` e `prepare-commit` e resume a sessão. |
| `new-feature.md` | Leva uma ideia até spec e tickets, sem implementar. |
| `fix.md` | Atalho para `fix-bug`. |
| `review.md` | Atalho para `review-code`. |
| `checkup.md` | Atalho para `health-check`, com área opcional. |
| `commit-msg.md` | Atalho para `prepare-commit`, com opção de PR ou release. |
| `audit-docs.md` | Dispara o `doc-auditor` e aplica só as correções aprovadas. |

#### `.agents/hooks/`

| Arquivo | Para que serve |
| --- | --- |
| `README.md` | O que são hooks, tabela dos scripts, convenção de entrada/saída, como ligar a cada ferramenta e como testar. |
| `lib.sh` | Funções compartilhadas: lê o evento (JSON ou texto), extrai campos, bloqueia. |
| `session-start.sh` | Injeta `STATUS.md` e a fronteira de tickets no início da sessão. |
| `guard-command.sh` | Bloqueia commit, push, merge, rebase, tag, criação/merge de PR e release, e comandos destrutivos. |
| `guard-files.sh` | Bloqueia escrita em `.env*`, chaves, certificados e `.git/`. |
| `post-edit.sh` | Formata e verifica o arquivo editado com as ferramentas do projeto. |
| `check-progress.sh` | Cobra o registro em `docs/progress/` quando há trabalho não registrado. |
| `examples/claude-code-settings.json` | Exemplo de configuração ligando os scripts aos eventos de uma ferramenta. |

#### `.agents/mcp/`

| Arquivo | Para que serve |
| --- | --- |
| `README.md` | O que são tools e MCP e as regras para usar servidores externos com segurança. |
| `servers.md` | Registro de cada servidor MCP: finalidade, acesso, credencial, responsável. |

### `docs/` — produto, arquitetura, decisões, processo e estado

| Arquivo | Para que serve |
| --- | --- |
| `README.md` | Índice com ordem de leitura, fluxo de documentos e hierarquia das fontes de verdade. |
| `glossary.md` | Linguagem única do domínio, com o termo no produto e no código. |
| `setup.md` | Pré-requisitos, primeira execução passo a passo, todas as variáveis de ambiente, serviços externos e problemas comuns. |

#### `docs/product/`

| Arquivo | Para que serve |
| --- | --- |
| `prd.md` | O **quê** e o **porquê**: problema, público, fluxos, regras de negócio, RF/RNF numerados, fora de escopo, métricas, riscos. |
| `user-stories.md` | Histórias `US-NN` com critérios de aceite testáveis e referência aos RFs. |
| `decisions-log.md` | Diário cronológico das decisões de produto; origem auditável do PRD. |

#### `docs/architecture/`

| Arquivo | Para que serve |
| --- | --- |
| `overview.md` | Mapa técnico: contexto, componentes, pastas, fluxo de dados, integrações, aspectos transversais, ambientes. |
| `domain-model.md` | Entidades do negócio, relações, ciclos de vida, **invariantes** e operações que precisam ser atômicas. É o que faz o agente entender o negócio. |
| `contracts.md` | Interfaces que outros usam (API, eventos, CLI, arquivos) e das quais dependemos, com política de compatibilidade e formato padrão de erro. |
| `conventions.md` | Contrato de padrões: princípios universais já preenchidos + decisões do projeto a preencher; patterns adotados; anti-padrões proibidos. |

#### `docs/decisions/`

| Arquivo | Para que serve |
| --- | --- |
| `README.md` | Índice de ADRs com status e regras de imutabilidade. |
| `0000-template.md` | Modelo de ADR. |
| `0001-documentacao-orientada-a-agentes.md` | Primeiro ADR: a adoção deste backbone, servindo de exemplo preenchido. |

#### `docs/specs/`

| Arquivo | Para que serve |
| --- | --- |
| `README.md` | Ordem de entrega, seam de teste padrão, estado atual do código, fora de escopo global. |
| `_template.md` | Modelo de spec: problema, solução, histórias, decisões de implementação e de teste, fora de escopo. |

#### `docs/process/`

| Arquivo | Para que serve |
| --- | --- |
| `definition-of-done.md` | Definition of Ready (quando um ticket pode começar) e Definition of Done (geral + adicionais por tipo de pedido). Todas as skills apontam para cá. |

#### `docs/reports/`

| Arquivo | Para que serve |
| --- | --- |
| `README.md` | Índice de todos os relatórios com data, tipo e conclusão. |
| `reviews/_template.md` | Relatório de review: verificações executadas, achados com severidade e status, o que está correto, o que não foi verificado. |
| `checkups/_template.md` | Relatório de checkup: estado e tendência por dimensão, três prioridades, evidências, encaminhamentos. |
| `investigations/_template.md` | Relatório de investigação: pergunta, critérios, alternativas, prova de conceito, recomendação com confiança, fontes. |

#### `docs/operations/`

| Arquivo | Para que serve |
| --- | --- |
| `runbook.md` | Ambientes, implantação, rollback, sinais de saúde, problemas conhecidos, escalonamento, backups. |
| `postmortems/_template.md` | Postmortem sem culpados: impacto, linha do tempo, causa raiz, ações corretivas com dono. |

#### `docs/progress/`

| Arquivo | Para que serve |
| --- | --- |
| `STATUS.md` | **Estado vivo**: em andamento, próximos passos, bloqueios, concluído recentemente, ideias e débitos. |
| `lessons-learned.md` | Memória de longo prazo de erros e correções; lições recorrentes são promovidas a rule. |
| `sessions/_template.md` | Diário de sessão: objetivo, o que foi feito, decisões, verificação real, problemas, próximo passo. |

### `tasks/` — trabalho executável

| Arquivo | Para que serve |
| --- | --- |
| `README.md` | Quadro: ordem, tipo, spec, bloqueios, status, fronteira atual e cobertura. |
| `_template.md` | Ticket de funcionalidade: o que construir, critérios de aceite, bloqueios. |
| `_template-bug.md` | Ticket de bug: reprodução, esperado vs. atual, hipóteses testadas, causa raiz. |

---

## Fluxo de trabalho

```
Qualquer pedido
   └─ AGENTS.md §3 (roteiro) ─► skill correspondente ─► Fechamento (registre / atualize / verifique / responda)

/new-feature "ideia"
   ├─ write-prd        → docs/product/*  + domain-model   (+ record-decision → docs/decisions/)
   ├─ write-spec       → docs/specs/NN-*.md + contracts
   └─ spec-to-tasks    → tasks/NN-*.md

/start-session NN                         ← hook session-start injeta STATUS
   └─ execute-task
        ├─ planner (subagente)        → plano
        ├─ testes + código            ← hooks guard-* protegem; post-edit formata e verifica
        ├─ review-code → code-reviewer → docs/reports/reviews/
        └─ Definition of Done          → docs atualizados

/fix  /review  /checkup                   → fix-bug, review-code, health-check

/end-session                              ← hook check-progress cobra o registro
   ├─ update-progress  → docs/progress/STATUS.md + sessions/
   └─ prepare-commit   → proposta de commits e PR
                           └─► VOCÊ revisa, commita, faz push e abre o PR

/audit-docs (periódico)
   └─ doc-auditor      → divergências entre docs e código
```

Rastreabilidade de ponta a ponta: um commit referencia o ticket → o ticket referencia a spec e as US → a spec referencia RFs, contratos e ADRs → os RFs vêm do PRD → o PRD vem do `decisions-log`. A qualquer momento dá para responder "por que este código existe?", "o que já foi verificado?" e "quem aprovou?".

---

## Manutenção do backbone

- Melhorias que valem para todo projeto voltam para este repositório.
- Quando uma skill, rule, hook ou subagente se provar útil em vários projetos, traga para cá.
- Skills e rules ligadas a uma tecnologia específica entram no projeto que as usa, não aqui.
- Toda skill nova precisa de uma linha no roteiro do `AGENTS.md`, e todo documento novo, de uma linha na rule `documentation.md`.
