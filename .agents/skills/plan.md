---
name: plan
description: Define o produto e especifica funcionalidades antes de implementar — entrevista, requisitos em docs/product.md e spec com fatias em docs/specs/. Use quando o usuário quiser definir um produto, planejar ou especificar uma funcionalidade nova, levantar requisitos ou quebrar um trabalho grande em partes.
---

# Planejar

Use só as fases que faltam. Se o produto já está definido, comece na fase 2.

## Fase 1 — Produto (quando `docs/product.md` não cobre o pedido)

1. Leia `docs/product.md` e `docs/decisions.md`.
2. Entreviste o usuário **uma pergunta por vez**, sempre com uma recomendação: problema, público, fluxos, regras de negócio, fora de escopo, requisitos não funcionais.
3. Atualize `docs/product.md`: requisitos numerados (`RF-NN`), histórias com critérios de aceite testáveis (`US-NN`), glossário, fora de escopo.
4. Registre em `docs/decisions.md` as decisões que tiveram alternativas reais.

## Fase 2 — Spec (trabalho de nível Grande)

1. Leia o produto, `docs/architecture.md`, `docs/conventions.md` e o código existente.
2. Copie `docs/specs/_template.md` para `docs/specs/NN-nome.md` e preencha: problema, solução, decisões de implementação, casos de teste e **fatias**.
3. Cada fatia é vertical (atravessa as camadas e entrega algo demonstrável sozinha) e cabe em uma sessão de trabalho.
4. Atualize `docs/architecture.md` com entidades, invariantes e contratos que a spec define.
5. Apresente a spec e espere aprovação antes de implementar.

## Boas práticas

- Pergunte pelo problema antes da solução.
- Requisito bom é verificável. "Fora de escopo" é tão importante quanto o escopo.
- Nenhuma decisão de tecnologia no `product.md`; ela vai para `decisions.md`.
- Não preencha lacunas sozinho: liste-as para o usuário.

## Fechamento

- **Registre:** `product.md`, spec, `decisions.md` — só o que mudou.
- **Atualize:** `STATUS.md` → "Próximo" com a primeira fatia.
- **Responda:** resumo do que foi definido, lacunas abertas, primeira fatia a implementar.
