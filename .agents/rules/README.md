# Rules

Rules são **instruções persistentes** que o agente segue sem precisar ser lembrado. São a "política da casa": como escrever código, como testar, o que nunca fazer.

## Formato

Cada rule é um `.md` com frontmatter:

```yaml
---
description: Uma frase dizendo do que a rule trata
always_apply: true                # true = vale em toda interação; false = só quando applies_to casar
applies_to: ["**/*"]              # globs; a rule é ativada quando o agente toca esses arquivos
---
```

Ajuste os `applies_to` às pastas reais do projeto quando quiser restringir uma rule (ex.: `testing.md` só para os arquivos de teste).

## Boas práticas

- **Curta e verificável.** "Funções com até 3 parâmetros" é uma rule. "Escreva código limpo" não é.
- **Uma rule por assunto.** Fica fácil ativar só o necessário e economizar contexto.
- **Diga o porquê.** O agente generaliza melhor quando entende a intenção.
- **Princípio, não dogma.** Regras absolutas ("sempre use design patterns", "nunca comente") produzem código pior. Escreva a regra com a condição em que ela vale.
- **Rule vs. Skill:** rule diz *como as coisas devem ser* (sempre); skill diz *como executar uma atividade* (sob demanda). Se tem passo a passo, é skill.
- **Rule vs. conventions.md:** `docs/architecture/conventions.md` explica os padrões com exemplos e guarda as escolhas específicas do projeto; as rules são a versão curta e imperativa. Mantenha as duas alinhadas.

## Onde fica cada tipo de boa prática

| Tipo | Onde |
| --- | --- |
| Comportamento do agente | `00-core.md` |
| Escrita de código (nomes, funções, comentários, erros, logs) | `code-style.md` + `conventions.md` |
| Design (simplicidade, patterns, princípios, fronteiras) | `design.md` + `conventions.md` §3 |
| Testes | `testing.md` |
| Git (o que é do humano, padrão de mensagens) | `git-workflow.md` |
| Segurança | `security.md` |
| Documentação | `documentation.md` |
| Práticas de cada atividade (review, bug, refatoração, investigação...) | Seção "Boas práticas" da skill correspondente |
| O que é "pronto" | `docs/process/definition-of-done.md` |

## Rules deste projeto

| Arquivo | Assunto | Sempre ativa |
| --- | --- | --- |
| `00-core.md` | Comportamento geral do agente | Sim |
| `documentation.md` | Manter a documentação sincronizada | Sim |
| `security.md` | Segredos, dados e dependências | Sim |
| `code-style.md` | Nomenclatura, funções, comentários, erros, logs | Ao tocar código |
| `design.md` | Simplicidade, design patterns, princípios, acoplamento | Ao tocar código |
| `testing.md` | Como e quando testar | Ao tocar código ou testes |
| `git-workflow.md` | Humano versiona (commit, push, PR); agente prepara os textos | Sim |
