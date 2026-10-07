---
name: refactor
description: Melhora a estrutura do código sem alterar o comportamento, em passos pequenos e sempre com testes verdes. Use quando o usuário pedir para refatorar, limpar, reorganizar, simplificar, extrair, renomear ou pagar débito técnico.
---

# Refatorar

## Quando NÃO usar

- A mudança altera o que o sistema faz → `execute-task` ou `fix-bug`. Se precisar das duas coisas, faça a refatoração primeiro e proponha commits separados.

## Passos

1. **Motivo.** Escreva em uma frase o problema estrutural (duplicação, função longa, acoplamento, nome ruim, pattern divergente) e o resultado esperado. Sem motivo concreto, não refatore.
2. **Rede de segurança.** Confirme que existem testes cobrindo o comportamento afetado. Se não houver, escreva testes de caracterização (que registram o comportamento atual) antes de mexer.
3. **Plano.** Liste os passos pequenos. Para refatorações grandes, use o subagente `planner` e apresente o plano ao usuário.
4. **Execução incremental.** Um passo por vez; testes após cada passo. A cada passo verde, pare e sugira ao humano um ponto de commit com a mensagem pronta (skill `prepare-commit`).
5. **Verificação.** Suíte completa, lint e build. Nenhum teste foi alterado para passar (exceto renomeações mecânicas).
6. **Revisão.** Skill `review-code`.

## Boas práticas

- Nunca misture refatoração com mudança de comportamento no mesmo commit.
- Use as refatorações automáticas da ferramenta/IDE (renomear, extrair) quando existirem: são mais seguras que editar à mão.
- Pare quando o motivo do passo 1 estiver resolvido. Refatoração sem limite vira reescrita.
- Se a refatoração introduz ou remove um pattern, siga `.agents/rules/design.md`.

## Fechamento

- **Registre:** sessão em `docs/progress/sessions/`.
- **Atualize:** `conventions.md` se o padrão mudou; ADR se a mudança for estrutural; remova o item correspondente de "Ideias e débitos" no `STATUS.md`; `overview.md` se a estrutura de pastas ou módulos mudou.
- **Verifique:** Definition of Done geral + adicionais de "Refatoração".
- **Responda:** problema resolvido, passos executados, evidência de que o comportamento não mudou e a proposta de commits (skill `prepare-commit`).
