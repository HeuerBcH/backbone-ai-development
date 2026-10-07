---
name: write-spec
description: Escreve uma especificação de desenvolvimento em docs/specs/ a partir do PRD e das user stories, pronta para ser executada por um agente. Use quando o usuário pedir para especificar, planejar ou detalhar uma etapa, épico ou funcionalidade antes de implementar.
---

# Escrever Spec

A spec é a ponte entre o PRD (o quê) e o código (como). Uma boa spec permite que um agente implemente sem precisar adivinhar.

## Passos

1. Leia o PRD, as user stories, os ADRs aceitos, `docs/architecture/overview.md`, `domain-model.md`, `contracts.md` e `conventions.md`.
2. Explore o código existente para descobrir o estado atual e os padrões já usados.
3. Defina o recorte: uma spec cobre uma **etapa entregável**, não o produto inteiro. Confirme o recorte com o usuário.
4. Copie `docs/specs/_template.md` para `docs/specs/NN-nome-curto.md` (NN = ordem de entrega).
5. Preencha todas as seções. Em "Decisões de implementação", seja concreto: módulos, contratos, regras de validação, transações, erros, permissões. Em "Decisões de teste", defina a seam e os casos obrigatórios.
6. Marque o status como `ready-for-agent` só depois que o usuário aprovar e "Riscos e questões em aberto" estiver vazio.

## Boas práticas

- Referencie em vez de repetir: aponte para `conventions.md`, `contracts.md` e ADRs.
- Cada caso de teste obrigatório corresponde a um critério de aceite de uma US.
- Se a spec exigir uma decisão que o PRD não tomou, pare e volte ao `write-prd`.

## Fechamento

- **Registre:** `docs/specs/NN-nome.md` e a linha na tabela "Ordem de entrega" de `docs/specs/README.md`.
- **Atualize:** `contracts.md` e `domain-model.md` com o que a spec define; ADR para decisões estruturais; `STATUS.md` com a spec em andamento.
- **Verifique:** toda US do cabeçalho aparece em "Histórias cobertas"; nenhuma contradição com ADR aceito.
- **Responda:** resumo da spec, decisões tomadas, pontos que precisam de aprovação, próximo passo (`spec-to-tasks`).
