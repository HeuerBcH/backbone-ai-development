---
description: Leva uma ideia de funcionalidade até specs e tickets prontos para execução
argument-hint: "<descrição da funcionalidade>"
---

Funcionalidade pedida: $ARGUMENTS

1. Verifique no PRD se a funcionalidade já está prevista. Se não estiver, use a skill `write-prd` para incorporá-la (entrevista curta, focada só nela).
2. Use a skill `write-spec` para criar a spec da etapa.
3. Após a aprovação da spec, use a skill `spec-to-tasks`.
4. Registre como ADR qualquer decisão relevante tomada no caminho (skill `record-decision`).
5. Termine com o grafo de tickets e qual deles pode começar agora. Não implemente nada neste command.
