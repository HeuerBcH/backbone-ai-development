---
name: spec-to-tasks
description: Quebra uma spec de docs/specs/ em tickets de fatia vertical em tasks/, com critérios de aceite e dependências. Use quando o usuário pedir para criar tickets, tarefas, issues ou um backlog a partir de uma spec.
---

# Spec para Tasks

Cada ticket é uma **fatia vertical**: atravessa todas as camadas necessárias e entrega algo demonstrável sozinho.

## Passos

1. Leia a spec inteira e o quadro atual em `tasks/README.md` para continuar a numeração.
2. Liste as fatias possíveis, da mais fundamental para a mais dependente. Cada fatia deve caber em uma sessão de trabalho de um agente.
3. Para cada fatia, copie `tasks/_template.md` para `tasks/NN-nome-curto.md` e preencha o que construir, bloqueios e critérios de aceite.
4. Confira cada ticket contra a Definition of Ready (`docs/process/definition-of-done.md`).
5. Apresente ao usuário a lista e o grafo de dependências para validação.

## Boas práticas

- Evite tickets horizontais ("criar todas as tabelas", "fazer todas as telas"): não entregam nada demonstrável e escondem problemas de integração.
- Prefira mais tickets pequenos a poucos grandes.
- O primeiro ticket deve ser o caminho mais fino de ponta a ponta.

## Fechamento

- **Registre:** arquivos em `tasks/` e o quadro em `tasks/README.md` (ordem, bloqueios, fronteira atual, cobertura).
- **Atualize:** status da spec para `em execução` quando o primeiro ticket começar; `STATUS.md` com os próximos passos.
- **Verifique:** todo critério de aceite da spec está em algum ticket; todos atendem à Definition of Ready.
- **Responda:** lista de tickets, grafo de dependências e quais podem começar agora.
