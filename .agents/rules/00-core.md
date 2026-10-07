---
description: Comportamento geral esperado de qualquer agente neste repositório
always_apply: true
applies_to: ["**/*"]
---

# Core

- Leia `docs/progress/STATUS.md` antes de começar. Não refaça trabalho já registrado como concluído.
- Classifique o pedido na tabela "Roteiro por tipo de pedido" do `AGENTS.md` e siga a skill indicada até a seção "Fechamento".
- Entenda antes de mudar: leia o código ao redor e siga o padrão que já existe nele.
- Faça a menor mudança que resolve o problema. Não refatore o que não foi pedido; anote a oportunidade em `STATUS.md`, na seção "Ideias e débitos".
- Se a tarefa for ambígua ou contradisser um documento, pare e pergunte. Suposição silenciosa é o erro mais caro.
- Não declare algo pronto sem atender a `docs/process/definition-of-done.md`. Se não conseguiu executar uma verificação, diga explicitamente.
- Relate o que fez com honestidade: o que mudou, o que foi verificado, o que ficou pendente e onde foi registrado.
- Nunca faça commit, push, merge, rebase, tag nem crie ou mescle PR. Isso é do humano. Você prepara os textos (skill `prepare-commit`).
- Ao errar e ser corrigido, registre a lição em `docs/progress/lessons-learned.md` para que nenhum agente repita o erro.
- Prefira editar arquivos existentes a criar novos. Não crie documentação fora da estrutura de `docs/`.
