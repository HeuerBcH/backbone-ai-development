# AGENTS.md

> Porta de entrada para qualquer agente de IA neste repositório. Leia inteiro antes de agir.

## 1. Projeto

**Nome:** {{NOME_DO_PROJETO}}
**Objetivo em uma frase:** {{O_QUE_O_PROJETO_RESOLVE_E_PARA_QUEM}}
**Idioma da documentação:** Português do Brasil
**Idioma do código (identificadores, mensagens de commit):** {{IDIOMA}}

## 2. Antes de agir

1. Leia [`docs/STATUS.md`](docs/STATUS.md) (estado atual) e [`docs/lessons.md`](docs/lessons.md) (erros a não repetir).
2. Defina o **nível** do pedido (seção 3) e o **tipo** (seção 4).
3. Ao tocar código, siga [`.agents/rules/code.md`](.agents/rules/code.md) e [`docs/conventions.md`](docs/conventions.md).

## 3. Nível do pedido

Comece pelo menor nível que faz sentido. **Suba de nível** se aparecer qualquer gatilho abaixo, e avise o usuário quando subir.

| Nível | Exemplos | Como fazer | Pronto quando |
| --- | --- | --- | --- |
| **Rápido** (rotina) | Perguntas, explicações, rodar um comando, ajuste de texto/estilo/config, renomear, bug óbvio e localizado, mensagem de commit | Direto, sem skill e sem registro | O afetado foi verificado (teste/lint do trecho) e a resposta diz o que mudou + proposta de commit |
| **Padrão** | Funcionalidade pequena e clara, bug que exige investigação, refatoração localizada, review, checkup de uma área | Skill do tipo (seção 4) | Testes, lint e build passando; docs afetados atualizados; `STATUS.md` atualizado se o estado mudou; proposta de commit |
| **Grande** | Funcionalidade com regras de negócio novas, mudança de arquitetura, trabalho de várias sessões, incidente em produção | Skill `plan` antes de executar; depois execução por fatias | Tudo do Padrão + spec com fatias marcadas + decisões registradas + revisão pelo subagente `reviewer` |

**Gatilhos que sobem o nível** (Rápido → Padrão, Padrão → Grande):

- Muda um contrato público (API, evento, formato de arquivo), dados persistidos ou permissões.
- Exige escolher entre alternativas reais (vira entrada em `docs/decisions.md`).
- Atravessa vários módulos ou camadas.
- O requisito está ambíguo ou contradiz um documento.
- Há risco para produção, segurança ou dados de usuários.

Se o usuário pedir explicitamente para ir rápido ("só faz", "rapidinho"), respeite, **exceto** diante de risco de segurança ou de dados: nesse caso avise antes de agir.

## 4. Tipo do pedido

| Pedido | Leia e siga |
| --- | --- |
| Definir produto, especificar funcionalidade, quebrar em fatias | [`.agents/skills/plan.md`](.agents/skills/plan.md) |
| Implementar funcionalidade ou fatia; refatorar | [`.agents/skills/build.md`](.agents/skills/build.md) |
| Corrigir bug; incidente em produção | [`.agents/skills/fix.md`](.agents/skills/fix.md) |
| Revisar código, branch ou PR | [`.agents/skills/review.md`](.agents/skills/review.md) |
| Checkup do projeto ou de uma área; dependências; auditoria de docs | [`.agents/skills/checkup.md`](.agents/skills/checkup.md) |
| Pesquisar, comparar opções, estudar viabilidade | [`.agents/skills/investigate.md`](.agents/skills/investigate.md) |
| Encerrar trabalho, salvar progresso, mensagem de commit, descrição de PR | [`.agents/skills/wrap-up.md`](.agents/skills/wrap-up.md) |
| Pergunta ou explicação | Responda citando `arquivo:linha`. Sem skill. |

Cada skill é um único arquivo e diz o que muda em cada nível. No nível Rápido, não é preciso abri-las.

## 5. Comandos do projeto

| Ação | Comando |
| --- | --- |
| Instalar | `{{COMANDO}}` |
| Rodar | `{{COMANDO}}` |
| Testes | `{{COMANDO}}` |
| Lint | `{{COMANDO}}` |
| Formatar | `{{COMANDO}}` |
| Build | `{{COMANDO}}` |
| Dependências desatualizadas / vulneráveis | `{{COMANDO}}` |

Ambiente do zero e variáveis: [`docs/setup.md`](docs/setup.md).

## 6. Fontes de verdade

Em conflito, vale a de cima: `docs/decisions.md` → `docs/product.md` → `docs/architecture.md` → `docs/specs/` → código. Não resolva conflitos sozinho: aponte ao usuário e registre em "Bloqueios" no `STATUS.md`.

## 7. Regras de ouro

- **Nunca faça commit, push, merge, rebase, tag, nem crie ou mescle PR.** Isso é do humano. Você prepara as mensagens (skill `wrap-up`).
- Não invente requisito. Na dúvida, pergunte.
- Não declare pronto o que não verificou. Se não conseguiu verificar, diga.
- Faça a menor mudança que resolve. Melhorias fora do pedido vão para "Débitos e ideias" no `STATUS.md`.
- Nunca escreva segredos ou dados reais de usuários no repositório.

## 8. Mapa

| Caminho | Conteúdo |
| --- | --- |
| `.agents/rules/` | `core.md` (sempre) e `code.md` (ao tocar código) |
| `.agents/skills/` | Roteiros, um arquivo por skill: `plan.md`, `build.md`, `fix.md`, `review.md`, `checkup.md`, `investigate.md`, `wrap-up.md` |
| `.agents/agents/` | Subagentes: `reviewer`, `auditor` |
| `.agents/hooks/` | Scripts automáticos: proteção, formatação, estado no início da sessão |
| `docs/STATUS.md` | Estado atual: agora, próximo, bloqueios, débitos |
| `docs/product.md` | O quê e por quê: requisitos, histórias, glossário |
| `docs/architecture.md` | Como: componentes, domínio, contratos |
| `docs/conventions.md` | Padrões de código escolhidos para este projeto |
| `docs/decisions.md` | Decisões e seus porquês |
| `docs/specs/` | Specs de trabalhos de nível Grande, com fatias |
| `docs/setup.md` / `docs/operations.md` | Ambiente local / produção e incidentes |
| `docs/lessons.md` | Lições aprendidas |
| `docs/reports/` | Relatórios de review, checkup e investigação de nível Grande |
| `CHANGELOG.md` | Mudanças visíveis por versão |
