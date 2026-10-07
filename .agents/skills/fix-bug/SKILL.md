---
name: fix-bug
description: Corrige um bug a partir da reprodução, com teste de regressão e causa raiz registrada. Use quando o usuário relatar erro, falha, comportamento inesperado, exceção, "não funciona", "quebrou" ou pedir para corrigir um problema.
---

# Corrigir Bug

## Quando NÃO usar

- O sistema está fora do ar ou afetando usuários agora → `handle-incident` primeiro.
- O comportamento é o especificado, mas o usuário quer outro → é mudança de requisito: `write-prd` / `write-spec`.

## Passos

1. **Reproduza.** Obtenha passos exatos, comportamento esperado e comportamento atual. Reproduza localmente. Se não conseguir, pare e reporte o que tentou; não corrija às cegas.
2. **Ticket.** Crie `tasks/NN-bug-descricao.md` a partir de `tasks/_template-bug.md` (ou atualize o existente) com a reprodução.
3. **Teste que falha.** Escreva um teste que reproduz o bug e confirme que ele falha pelo motivo certo.
4. **Causa raiz.** Investigue até a origem, não até o sintoma. Pergunte "por quê?" até chegar a algo que, corrigido, impede a classe inteira do erro. Registre as hipóteses testadas e descartadas no ticket.
5. **Correção.** Faça a menor mudança que corrige a causa raiz. O teste do passo 3 passa.
6. **Varredura.** Procure o mesmo padrão de erro em outros pontos do código. Corrija ou registre como ticket.
7. **Verificação.** Rode a suíte completa, lint e build.
8. **Revisão.** Skill `review-code` sobre a correção.

## Boas práticas

- Uma hipótese por vez; mude uma coisa, observe, conclua.
- Leia a mensagem de erro e o stack trace inteiros antes de levantar hipóteses.
- Nunca "corrija" suprimindo o erro, aumentando timeouts ou adicionando retentativas sem entender a causa.
- Se a causa for um requisito ambíguo, a correção inclui esclarecer o documento de origem.

## Fechamento

- **Registre:** ticket de bug com causa raiz, hipóteses descartadas e correção; sessão em `docs/progress/sessions/`.
- **Atualize:** `CHANGELOG.md` em "Corrigido"; `STATUS.md`; `lessons-learned.md` se a causa revelar uma falha de processo ou um erro que agentes tendem a repetir; spec/PRD se o requisito estava ambíguo.
- **Verifique:** Definition of Done geral + adicionais de "Bug".
- **Responda:** causa raiz em uma frase, o que foi corrigido, teste de regressão adicionado, outros pontos afetados encontrados e a proposta de commit (skill `prepare-commit`).
