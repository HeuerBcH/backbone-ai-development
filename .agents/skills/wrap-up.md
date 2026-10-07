---
name: wrap-up
description: Encerra um trabalho — atualiza o estado do projeto e prepara, para o humano executar, a proposta de commits, a descrição de PR e notas de release. Use quando o usuário disser encerrar, finalizar, salvar progresso, handoff, ou pedir mensagem de commit, texto de commit, descrição de PR ou notas de release.
---

# Fechar o trabalho

O agente **prepara**; o humano **executa**. Esta skill nunca roda `add`, `commit`, `push` nem cria PR.

Se o pedido for só a mensagem de commit, pule para o passo 3.

## Passos

1. **Estado.** Atualize `docs/STATUS.md`: data, "Agora", "Próximo" (o primeiro item deve ser acionável sem perguntar nada), "Bloqueios", "Débitos e ideias".
2. **Conferência.** `CHANGELOG.md`, `docs/decisions.md` e `docs/lessons.md` refletem o que aconteceu? Complete o que faltar.
3. **Proposta de commits.** A partir de `git status` e `git diff`, agrupe os arquivos em commits coerentes (refatoração separada de comportamento; docs junto do código que descrevem) e escreva cada mensagem:

   ```
   tipo(escopo): resumo no imperativo, até ~72 caracteres

   Por que a mudança foi necessária.

   Refs: docs/specs/NN, D-NNN
   BREAKING CHANGE: <se houver>
   ```

   Tipos: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, `perf`, `build`, `ci`.
4. **PR (se pedido):** o que muda, por quê, como testar, verificações executadas, riscos, docs atualizados, referências.
5. **Release (se pedido):** notas a partir de "Não lançado" no `CHANGELOG.md`.

## Formato da entrega

Para cada commit: lista de arquivos + mensagem em bloco de código. No fim, os comandos sugeridos (`git add ...` e `git commit ...`) **para o humano executar**.

## Boas práticas

- O resumo diz o que muda para quem usa ou mantém; nada de "ajustes" ou "correções".
- Não escreva "testado" se não foi.
- Mudanças misturadas que não formam commits coerentes: diga e sugira como separar.

## Fechamento

- **Verifique:** todo arquivo do `git status` está em algum commit proposto ou deixado de fora com motivo.
- **Responda:** o que foi feito, o que foi verificado, pendências, a proposta de commits e o primeiro passo do próximo trabalho.
