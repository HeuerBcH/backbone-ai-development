---
name: execute-task
description: Implementa um ticket de tasks/ ou uma funcionalidade já especificada, de ponta a ponta — planejamento, testes, código, revisão e documentação. Use quando o usuário pedir para implementar, fazer, construir, desenvolver, executar ou começar um ticket, task ou funcionalidade.
---

# Executar Task

## Quando NÃO usar

- Não há spec nem ticket para o pedido → skills `write-prd`/`write-spec`/`spec-to-tasks` primeiro. Para mudanças pequenas e óbvias, confirme com o usuário se pode seguir sem spec e registre isso na sessão.
- É correção de bug → `fix-bug`. É só reestruturação → `refactor`.

## Passos

1. **Contexto.** Leia `docs/progress/STATUS.md`, o ticket, a spec de origem, os ADRs citados e os `contracts.md`/`domain-model.md` relevantes.
2. **Pronto para começar?** Confira a Definition of Ready (`docs/process/definition-of-done.md`). Se falhar, pare e avise.
3. **Status.** Marque o ticket como `in-progress` e registre em "Em andamento" no `STATUS.md`.
4. **Plano.** Para mudanças não triviais, use o subagente `planner` e apresente o plano antes de alterar arquivos.
5. **Branch.** Crie a branch local conforme `.agents/rules/git-workflow.md` (criar branch é permitido; commitar não).
6. **Testes primeiro.** Escreva testes para os critérios de aceite na seam definida pela spec. Confirme que falham pelo motivo certo.
7. **Implementação.** Faça os testes passarem seguindo `conventions.md`, `code-style.md` e `design.md`. Marque cada checkbox do ticket conforme for cumprido.
8. **Verificação.** Testes, lint e build. Não avance com falhas.
9. **Revisão.** Skill `review-code` e tratamento dos achados.

## Boas práticas

- Ticket grande demais → proponha dividi-lo em vez de entregar pela metade.
- Requisito ambíguo → pare, pergunte, registre em "Bloqueios".
- Problema fora do escopo → anote em "Ideias e débitos"; não resolva agora.
- Reaproveite o que já existe no projeto antes de criar algo novo.

## Fechamento

- **Registre:** checkboxes e status `done` no ticket; `tasks/README.md` (status e fronteira atual); skill `update-progress`.
- **Atualize:** tudo que `.agents/rules/documentation.md` exigir para esta mudança (CHANGELOG, contratos, domínio, setup, glossário, ADR...).
- **Verifique:** Definition of Done geral + adicionais de "Funcionalidade".
- **Responda:** o que foi entregue, como foi verificado, pendências, documentos atualizados, a proposta de commits e descrição de PR (skill `prepare-commit`) e o próximo ticket da fronteira.
