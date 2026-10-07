---
name: fix
description: Corrige bugs pela causa raiz, com teste de regressão, e conduz incidentes em produção. Use quando o usuário relatar erro, falha, exceção, comportamento inesperado, "não funciona", "quebrou", ou sistema fora do ar.
---

# Corrigir

Bug óbvio e localizado (causa evidente, uma linha, sem risco) é nível Rápido: corrija, verifique e responda. O roteiro abaixo é para o resto.

## Bug

1. **Reproduza.** Passos, esperado e atual. Sem reprodução, não corrija às cegas: reporte o que tentou.
2. **Teste que falha** reproduzindo o bug.
3. **Causa raiz.** Pergunte "por quê?" até chegar à origem, não ao sintoma. Uma hipótese por vez.
4. **Corrija** a causa com a menor mudança. O teste passa.
5. **Varra** o código atrás do mesmo padrão de erro.
6. **Verifique:** suíte completa, lint, build.

## Incidente em produção

1. **Estabilize antes de investigar:** siga `docs/operations.md` (rollback, desativar funcionalidade). Toda ação em produção exige confirmação humana.
2. Anote a linha do tempo com horários enquanto acontece.
3. Com o sistema estável, siga o roteiro de **Bug** para a correção definitiva.
4. Registre o incidente em `docs/operations.md` → "Incidentes": impacto, linha do tempo, causa raiz, ações corretivas com dono. Sem culpados.

## Boas práticas

- Leia a mensagem de erro e o stack trace inteiros antes de levantar hipóteses.
- Nunca "corrija" suprimindo o erro, aumentando timeout ou adicionando retentativa sem entender a causa.
- Se a causa for requisito ambíguo, corrija também o documento.

## Fechamento

- **Registre:** `CHANGELOG.md` → "Corrigido"; `lessons.md` se a causa for um erro que tende a se repetir; incidente em `operations.md`.
- **Responda:** causa raiz em uma frase, correção, teste adicionado, outros pontos afetados e a proposta de commit.
