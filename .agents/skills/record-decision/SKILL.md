---
name: record-decision
description: Registra uma decisão de arquitetura, tecnologia ou produto como ADR em docs/decisions/. Use quando uma escolha entre alternativas reais for feita, quando o usuário disser "decidimos", "vamos usar", "escolhemos", ou quando uma decisão anterior for substituída.
---

# Registrar Decisão (ADR)

Um ADR (Architecture Decision Record) responde, meses depois, à pergunta "por que está assim?".

## Quando vale um ADR

- Escolha de tecnologia, biblioteca estrutural, padrão de arquitetura, design pattern estrutural ou formato de dados.
- Regra de negócio com impacto técnico relevante.
- Qualquer coisa que um novo integrante questionaria ou tentaria "consertar".

Não vale para escolhas triviais e reversíveis em minutos.

## Passos

1. Veja o maior número em `docs/decisions/` e use o próximo.
2. Copie `docs/decisions/0000-template.md` para `docs/decisions/NNNN-titulo-curto.md`.
3. Preencha contexto, alternativas consideradas (pelo menos duas, com prós e contras), decisão e consequências — incluindo as negativas.
4. Status inicial: `proposto`. Mude para `aceito` só com a confirmação do usuário.
5. Se substituir um ADR anterior, marque o antigo como `substituído por NNNN` e não apague seu conteúdo.

## Boas práticas

- Escreva para alguém que chega daqui a um ano sem nenhum contexto.
- Registre as consequências negativas aceitas; elas são as mais úteis depois.
- ADRs aceitos são **imutáveis**. Mudou de ideia? Novo ADR que substitui o anterior.

## Fechamento

- **Registre:** o ADR e a linha no índice de `docs/decisions/README.md`.
- **Atualize:** `conventions.md` e a rule correspondente se a decisão muda um padrão; `overview.md` se muda a arquitetura; `.agents/models.md` se muda o uso de modelos.
- **Verifique:** pelo menos duas alternativas com prós e contras; status coerente.
- **Responda:** a decisão em uma frase, o status e o link.
