---
name: build
description: Implementa uma funcionalidade, uma fatia de spec ou uma refatoração, com testes e documentação. Use quando o usuário pedir para implementar, construir, desenvolver, adicionar, fazer uma fatia, refatorar, reorganizar ou limpar código.
---

# Construir

## Passos

1. **Contexto.** Leia o pedido e, se houver, a fatia na spec. Confira em `STATUS.md` se não há bloqueio. Se o pedido não estiver claro o suficiente para escrever um teste, pergunte.
2. **Plano.** Padrão: plano mental, siga. Grande: plano curto (arquivos, abordagem, testes) apresentado ao usuário antes de mudanças amplas.
3. **Teste primeiro.** Escreva o teste do comportamento esperado e veja falhar pelo motivo certo.
4. **Implemente** o mínimo para passar, seguindo `.agents/rules/code.md` e `docs/conventions.md`. Reaproveite o que o projeto já tem.
5. **Verifique:** testes, lint e build.
6. **Revise.** Grande: delegue ao subagente `reviewer` e trate os achados. Padrão: releia o próprio diff antes de entregar.

## Refatoração

- Antes: confirme que há testes cobrindo o comportamento; se não houver, escreva-os primeiro.
- Passos pequenos, testes verdes a cada passo. Nenhum teste alterado para passar.
- Nunca misture refatoração com mudança de comportamento na mesma proposta de commit.
- Pare quando o problema que motivou a refatoração estiver resolvido.

## Boas práticas

- Fatia grande demais → proponha dividir em vez de entregar pela metade.
- Problema fora do escopo → "Débitos e ideias" no `STATUS.md`, não resolva agora.

## Fechamento

- **Registre:** marque a fatia na spec (Grande); `STATUS.md` se o estado mudou.
- **Atualize:** o que a mudança afetou, conforme a tabela de documentação em `.agents/rules/core.md`.
- **Responda:** o que foi feito, como foi verificado, pendências e a proposta de commit (skill `wrap-up`).
