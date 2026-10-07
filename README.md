# backbone-ai-development

Estrutura base para desenvolver qualquer projeto com agentes de IA de forma **rastreável, padronizada e proporcional**. Você copia para a raiz de um projeto novo, segue o guia abaixo, e qualquer agente que abrir o projeto passa a saber: o que é o projeto, onde ele está, quais padrões seguir, como tratar cada pedido e onde registrar o que fez.

**Proporcional** é a palavra-chave: pedido de rotina se resolve direto; só trabalho grande paga o custo de planejamento e registro completos.

---

## Sumário

**Para usar:** [Os três níveis](#os-três-níveis) · [Configurar um projeto novo](#configurar-um-projeto-novo) · [Uso no dia a dia](#uso-no-dia-a-dia) · [O que é seu e o que é da IA](#o-que-é-seu-e-o-que-é-da-ia)

**Para entender:** [Conceitos](#conceitos) · [Estrutura e arquivos](#estrutura-e-arquivos) · [Quando o projeto crescer](#quando-o-projeto-crescer)

---

## Os três níveis

Antes de agir, o agente classifica o pedido (`AGENTS.md` §3). É isso que evita dar voltas para resolver coisas simples.

| Nível | Exemplos | O que a IA faz | O que fica registrado |
| --- | --- | --- | --- |
| **Rápido** (rotina) | Perguntas, explicações, rodar um comando, ajustar texto/estilo/config, renomear, bug óbvio, mensagem de commit | Faz direto e verifica o trecho afetado | Nada além da resposta (e proposta de commit se mudou arquivo) |
| **Padrão** | Funcionalidade pequena e clara, bug que exige investigação, refatoração localizada, review, checkup de uma área | Segue a skill do tipo | Só os documentos que a mudança afetou + `STATUS.md` se o estado mudou |
| **Grande** | Funcionalidade com regras novas, mudança de arquitetura, várias sessões, incidente | Planeja (spec com fatias), executa por fatias, revisão independente | Spec, decisões, documentos afetados, relatório quando aplicável |

**O nível sobe** automaticamente se aparecer um gatilho: mexe em contrato público, dados persistidos ou permissões; exige escolher entre alternativas; atravessa vários módulos; requisito ambíguo; risco em produção ou segurança. A IA avisa quando sobe.

Você também pode forçar: "só faz", "rapidinho" → Rápido (a IA só alerta se houver risco de segurança ou de dados).

---

## Configurar um projeto novo

### 1. Copiar

Na pasta do projeto, copie tudo exceto `.git/` e este `README.md`:

```sh
# Linux / macOS / Git Bash
tar -C /caminho/backbone-ai-development --exclude=./.git --exclude=./README.md -cf - . | tar -xf -
```

```powershell
# Windows PowerShell
Get-ChildItem -Force C:\caminho\backbone-ai-development |
  Where-Object { $_.Name -notin '.git', 'README.md' } |
  Copy-Item -Destination . -Recurse -Force
```

Crie o `README.md` do projeto (o que é e como rodar, apontando para `docs/setup.md`). Garanta que o `.gitignore` do projeto ignora `.env` e `.env.*`, mantendo `.env.example`.

### 2. Identificar o projeto

No `AGENTS.md` §1: nome, objetivo, idiomas. Os comandos (§5) ficam para o passo 6.

### 3. Ligar à ferramenta de IA

**Claude Code**

- `CLAUDE.md` já importa `AGENTS.md` e a rule `core.md`.
- Links para skills e subagentes. As skills são arquivos `.md` soltos, então entram como **commands** (`/plan`, `/build`, `/fix`...):

  ```sh
  # Linux / macOS
  mkdir -p .claude && ln -s ../.agents/skills .claude/commands && ln -s ../.agents/agents .claude/agents
  ```

  ```powershell
  # Windows (junction não exige administrador)
  New-Item -ItemType Directory -Force .claude | Out-Null
  New-Item -ItemType Junction -Path .claude\commands -Target .agents\skills
  New-Item -ItemType Junction -Path .claude\agents   -Target .agents\agents
  ```

  Time com sistemas operacionais diferentes: adicione `.claude/commands` e `.claude/agents` ao `.gitignore`, e cada pessoa cria os links ao clonar.
- Nos subagentes (`.agents/agents/*.md`), troque `tools: [read, search, bash]` por `tools: Read, Grep, Glob, Bash`, ou remova a linha.
- Hooks: copie `.agents/hooks/examples/claude-code-settings.json` para `.claude/settings.json`.

**Outras ferramentas** (Codex, Cursor, Copilot, Gemini CLI, Windsurf...): leem o `AGENTS.md` sozinhas, e ele aponta para todo o resto. Se a ferramenta tiver pastas próprias de rules, skills ou hooks, ligue-as às de `.agents/` (veja `.agents/README.md`).

**Teste:**

```sh
printf '{"tool_input":{"command":"git commit -m x"}}' | sh .agents/hooks/guard.sh; echo "saída: $?"
# esperado: "BLOQUEADO: ..." e saída: 2
```

### 4. Registrar o início

Preencha a data em `docs/decisions.md` (D-001) e em `docs/STATUS.md` (fase "descoberta", próximo passo "Definir o produto").

### 5. Definir o produto

Diga à IA "quero definir o produto" (ou `/plan` no Claude Code). Ela entrevista você uma pergunta por vez e preenche `docs/product.md`.

### 6. Escolher tecnologias e fixar padrões

Peça para investigar as opções; registre as escolhas em `docs/decisions.md`. Depois, preencha:

| Arquivo | O quê |
| --- | --- |
| `AGENTS.md` §5 | Comandos de instalar, rodar, testar, lint, formatar, build, auditar dependências |
| `docs/conventions.md` | Padrão de nomes, ferramentas, patterns adotados |
| `docs/setup.md` + `.env.example` | Pré-requisitos, primeira execução, variáveis |
| `docs/architecture.md` | Componentes, domínio, contratos (cresce junto com o projeto) |
| `.agents/hooks/post-edit.sh` | `FORMAT_CMD` e `LINT_CMD` |
| `.agents/README.md` | Modelos por tipo de trabalho; servidores MCP |

Skills de boas práticas das tecnologias escolhidas podem ser instaladas com `npx skills add <org>/<repo>`. Elas vêm no formato padrão de pasta (`nome/SKILL.md`); mantenha assim e acrescente uma linha no `AGENTS.md` §4 apontando para elas.

### 7. Começar

Primeira funcionalidade grande: "planeja a funcionalidade X" → aprove a spec → "implementa a fatia 1". Antes do primeiro deploy, preencha `docs/operations.md`.

---

## Uso no dia a dia

Peça em linguagem natural; a IA identifica nível e tipo. No Claude Code, as skills também funcionam como comandos (`/fix`, `/review`...).

| Você quer... | Diga | Skill | Nível típico |
| --- | --- | --- | --- |
| Uma resposta, explicação, ajuste pequeno | O que precisa, direto | — | Rápido |
| Definir ou planejar algo grande | "planeja X" | `plan` | Grande |
| Implementar ou refatorar | "implementa X", "refatora Y" | `build` | Padrão ou Grande |
| Corrigir um problema | "X está quebrando" | `fix` | Rápido a Grande |
| Uma revisão | "revisa minha branch" | `review` | Padrão |
| Um diagnóstico | "faz um checkup", "atualiza as dependências" | `checkup` | Padrão |
| Comparar opções | "investiga X vs Y" | `investigate` | Padrão ou Grande |
| Encerrar ou commitar | "encerra", "mensagem de commit" | `wrap-up` | Rápido |

**Rotina:** abra a sessão (o hook mostra o `STATUS.md`) → faça os pedidos → "encerra" → revise o diff → **você** commita, faz push e abre o PR.

**De tempos em tempos:** "faz um checkup" — inclui a auditoria da documentação.

---

## O que é seu e o que é da IA

| | Você | IA |
| --- | --- | --- |
| Decidir requisitos, prioridades, aprovar specs e decisões | ✅ | Propõe e pergunta |
| Implementar, testar, revisar, documentar | Revisa | ✅ |
| Criar branch local | ✅ | ✅ |
| `git add`, `commit`, `push`, `merge`, `rebase`, `tag`; criar ou mesclar PR; release | ✅ **exclusivo** | ❌ bloqueado (rule + hook) |
| Mensagens de commit, descrição de PR, notas de release | Revisa e usa | ✅ prepara |
| Ações em produção, apagar dados, editar `.env` e segredos | ✅ **exclusivo** | ❌ prepara o comando / bloqueado |

O commit é o registro de quem revisou e aprovou cada mudança, por isso fica com você. A regra está no `AGENTS.md`, na rule `core.md` e no hook `guard.sh`, que bloqueia os comandos mesmo que o modelo esqueça a regra.

---

## Conceitos

| Conceito | O que é | Aqui |
| --- | --- | --- |
| **Contexto** | Tudo que o modelo "vê" no momento: prompt, arquivos lidos, respostas de tools. Mais contexto não é melhor: o irrelevante dilui a atenção e custa dinheiro. | Camadas: `AGENTS.md` e `core.md` sempre; o resto sob demanda |
| **AGENTS.md** | Arquivo de instruções do projeto, padrão aberto lido pela maioria das ferramentas. O onboarding do agente. | Raiz; `CLAUDE.md` só o importa |
| **Rules** | Instruções persistentes: *como as coisas devem ser*. | `.agents/rules/` |
| **Skills** | Roteiros de uma atividade, carregados **sob demanda**: o agente só abre o roteiro quando o pedido casa com ele (*progressive disclosure*). O formato padrão do mercado é uma pasta por skill (`nome/SKILL.md`, com arquivos de apoio), que as ferramentas descobrem sozinhas. | `.agents/skills/` — um `.md` por skill, encontrado pelo roteiro do `AGENTS.md` §4 |
| **Tools** | Ações que o agente executa: ler, editar, rodar comandos, pesquisar. É o que faz de um chat um agente. | Nativas da ferramenta |
| **MCP** | Protocolo aberto para plugar tools externas (banco, navegador, issues, documentação) em qualquer agente compatível. | Registro em `.agents/README.md` |
| **Subagents** | Agentes especializados para quem o principal delega uma tarefa isolada, com contexto limpo e olhar independente. | `.agents/agents/` |
| **Hooks** | Scripts que a ferramenta executa em eventos. Diferente de rules e skills, **sempre** rodam: servem para o que não pode falhar. | `.agents/hooks/` |
| **Memória** | O agente esquece tudo entre sessões; a memória do projeto é escrita em arquivos versionados. | `STATUS.md`, `lessons.md`, `decisions.md` |
| **Spec-driven** | Nada grande é implementado antes de especificado; cada etapa reduz a ambiguidade da seguinte. | Skill `plan`, `docs/specs/` |
| **Registro de decisões** | Cada escolha entre alternativas reais, com o porquê. Só se acrescenta; mudar de ideia é uma nova entrada. | `docs/decisions.md` |

Regra prática: prompt que você repete vira **skill**; correção que você repete vira **rule** (ou lição em `lessons.md`); verificação que não pode falhar vira **hook**.

O repositório de inspiração (`vDev-quest`) mostra skills de terceiros em uso. A de boas práticas de React é um bom exemplo de *progressive disclosure*: o `SKILL.md` é um índice de 70 regras, cada uma em um arquivo com exemplo certo e errado, e o agente só abre a que precisa. O `skills-lock.json` registra origem e hash de cada skill, como um lockfile.

---

## Estrutura e arquivos

```
.
├── AGENTS.md                 # entrada: níveis, tipos, comandos, regras de ouro, mapa
├── CLAUDE.md                 # adaptador: importa AGENTS.md e core.md
├── CHANGELOG.md              # mudanças visíveis por versão
├── .env.example              # variáveis de ambiente, sem valores
├── .agents/
│   ├── README.md             # ligar ferramentas, modelos, servidores MCP
│   ├── rules/
│   │   ├── core.md           # sempre: comportamento, Git, segurança, documentação
│   │   └── code.md           # ao tocar código: nomes, funções, erros, design, testes
│   ├── skills/
│   │   ├── _template.md      # modelo para skills novas
│   │   ├── plan.md           # produto + spec com fatias
│   │   ├── build.md          # implementar e refatorar
│   │   ├── fix.md            # bugs e incidentes
│   │   ├── review.md         # revisão de código
│   │   ├── checkup.md        # saúde, dependências, auditoria de docs
│   │   ├── investigate.md    # pesquisa e comparação
│   │   └── wrap-up.md        # estado + proposta de commits/PR
│   ├── agents/
│   │   ├── reviewer.md       # revisão independente
│   │   └── auditor.md        # documentação vs. código
│   └── hooks/
│       ├── README.md
│       ├── session-start.sh  # mostra o STATUS no início
│       ├── guard.sh          # bloqueia Git/PR, ações destrutivas, segredos
│       ├── post-edit.sh      # formata e roda lint no arquivo editado
│       └── examples/claude-code-settings.json
└── docs/
    ├── STATUS.md             # agora, próximo, bloqueios, débitos
    ├── product.md            # o quê e por quê: requisitos, histórias, glossário
    ├── architecture.md       # como: componentes, domínio, contratos
    ├── conventions.md        # escolhas de padrão deste projeto
    ├── decisions.md          # decisões e porquês
    ├── setup.md              # ambiente local e variáveis
    ├── operations.md         # deploy, rollback, saúde, incidentes
    ├── lessons.md            # lições aprendidas
    ├── specs/                # specs de trabalhos Grandes (com fatias)
    └── reports/              # reviews, checkups e investigações registrados
```

| Arquivo | Para que serve | Quem atualiza e quando |
| --- | --- | --- |
| `AGENTS.md` | Primeiro arquivo que o agente lê. Define níveis, tipos → skill, comandos, fontes de verdade e regras de ouro. | Você, na configuração; IA quando comandos mudam |
| `CLAUDE.md` | Faz o Claude Code carregar o `AGENTS.md` e a rule `core.md`. | Raramente |
| `CHANGELOG.md` | Mudanças visíveis para quem usa. | IA, quando algo visível muda |
| `.env.example` | Lista das variáveis de ambiente, sem valores. | IA, junto com `setup.md` |
| `.agents/README.md` | Como ligar cada ferramenta; tabela de modelos; registro de servidores MCP. | Você |
| `rules/core.md` | Sempre ativa: classificar o pedido, Git é do humano, segurança, quais docs atualizar em cada tipo de mudança. | Raramente |
| `rules/code.md` | Princípios universais de código: nomes, funções, comentários, erros, design patterns com critério, testes. | Raramente |
| `skills/*.md` | Um arquivo por tipo de atividade, com passos, boas práticas e fechamento, e o que muda em cada nível. | Quando o processo do time mudar |
| `agents/reviewer.md` | Revisor cético e independente para trabalhos Grandes. | Raramente |
| `agents/auditor.md` | Compara documentação com código; chamado pelo `checkup`. | Raramente |
| `hooks/*` | Proteções e automações que sempre rodam. | Você, na configuração |
| `docs/STATUS.md` | Estado atual. Primeira leitura de toda sessão. | IA, quando o estado muda |
| `docs/product.md` | Requisitos (`RF`), regras, histórias (`US`), fora de escopo, glossário. | IA via `plan`, com sua aprovação |
| `docs/architecture.md` | Componentes, entidades e invariantes, contratos públicos. | IA, quando essas coisas mudam |
| `docs/conventions.md` | Escolhas do projeto: caixa de nomes, ferramentas, patterns adotados, proibições. | Você + IA, ao escolher tecnologias |
| `docs/decisions.md` | Registro de decisões; só se acrescenta. | IA propõe, você aceita |
| `docs/setup.md` | Da máquina vazia ao projeto rodando. | IA, quando o ambiente muda |
| `docs/operations.md` | Implantação, rollback, saúde, backups, incidentes. | Antes do primeiro deploy; após incidentes |
| `docs/lessons.md` | Erros a não repetir. Lição permanente vira rule ou convenção. | IA, quando é corrigida |
| `docs/specs/` | Uma spec por trabalho Grande, com fatias marcadas conforme avançam. | IA via `plan` e `build` |
| `docs/reports/` | Relatórios que precisam ficar: Grandes, checkups gerais ou a pedido. | IA via `review`, `checkup`, `investigate` |

---

## Quando o projeto crescer

A estrutura começa enxuta e cresce só quando precisa:

- **Arquivo grande demais** (~300 linhas numa seção): `product.md`, `architecture.md` e `decisions.md` viram pastas (`docs/product/`, `docs/architecture/`, `docs/decisions/`), com o arquivo original como índice.
- **Módulos com regras próprias:** crie um `AGENTS.md` dentro do módulo, só com o que difere da raiz (comandos locais, padrões locais, armadilhas). O agente lê o da raiz e o da pasta em que trabalha.
- **Correção que se repete:** vira lição em `lessons.md`; se continuar, vira regra em `rules/` ou em `conventions.md`.
- **Atividade nova recorrente:** copie `.agents/skills/_template.md` para `.agents/skills/<nome>.md` e acrescente uma linha no `AGENTS.md` §4.

Melhorias que valem para qualquer projeto voltam para este repositório; o que é específico de uma tecnologia fica no projeto que a usa.
