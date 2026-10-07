# Documentação

Índice de toda a documentação do projeto. A ordem abaixo é também a ordem em que um novo integrante (pessoa ou agente) deve ler.

| # | Documento | Responde à pergunta |
| --- | --- | --- |
| 1 | [`progress/STATUS.md`](progress/STATUS.md) | Onde estamos agora e o que vem a seguir? |
| 2 | [`product/prd.md`](product/prd.md) | O que estamos construindo e por quê? |
| 3 | [`glossary.md`](glossary.md) | O que significa cada termo do domínio? |
| 4 | [`architecture/domain-model.md`](architecture/domain-model.md) | Quais são as entidades, estados e regras invioláveis do negócio? |
| 5 | [`architecture/overview.md`](architecture/overview.md) | Como o sistema está organizado? |
| 6 | [`architecture/contracts.md`](architecture/contracts.md) | Quais interfaces os outros usam e de quais dependemos? |
| 7 | [`architecture/conventions.md`](architecture/conventions.md) | Quais padrões o código deve seguir? |
| 8 | [`decisions/`](decisions/) | Por que as coisas são do jeito que são? |
| 9 | [`setup.md`](setup.md) | Como rodar o projeto do zero? |
| 10 | [`process/definition-of-done.md`](process/definition-of-done.md) | Quando algo pode começar e quando está pronto? |
| 11 | [`specs/`](specs/) | Como cada etapa será construída? |
| 12 | [`product/user-stories.md`](product/user-stories.md) | O que cada usuário precisa conseguir fazer? |
| 13 | [`progress/lessons-learned.md`](progress/lessons-learned.md) | Que erros não devemos repetir? |
| 14 | [`reports/`](reports/) | O que já foi revisado, auditado ou investigado? |
| 15 | [`operations/runbook.md`](operations/runbook.md) | Como implantar, reverter e reagir a problemas? |

## Fluxo de documentos

```
Ideia
  └─► product/decisions-log.md   (entrevista, decisões de produto datadas)
        └─► product/prd.md        (o quê e por quê — RF/RNF numerados)
              ├─► product/user-stories.md   (US com critérios de aceite)
              └─► architecture/domain-model.md  (entidades e invariantes)
                    └─► specs/NN-*.md        (como — etapa entregável; define contracts.md)
                          └─► ../tasks/NN-*.md  (fatia vertical executável)
                                └─► código + testes
                                      └─► progress/ + CHANGELOG  (registro do que aconteceu)

Em qualquer ponto:
  decisão com alternativas reais ─► decisions/NNNN-*.md (ADR)
  review / checkup / investigação ─► reports/
  incidente ─► operations/postmortems/
```

## Hierarquia das fontes de verdade

Quando dois documentos discordarem: **ADR aceito > PRD > Contratos e modelo de domínio > Spec > Task > Código**. Divergências são apontadas ao humano e registradas como bloqueio em `STATUS.md`, nunca resolvidas silenciosamente.
