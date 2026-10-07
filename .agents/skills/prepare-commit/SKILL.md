---
name: prepare-commit
description: Prepara, para o humano executar, a proposta de commits (agrupamento de arquivos e mensagens no padrão Conventional Commits), a descrição de pull request e notas de release. Use quando o usuário pedir mensagem de commit, texto de commit, descrição de PR, "o que eu commito?", "como separo os commits?", notas de release, ou ao final de qualquer trabalho que alterou arquivos.
---

# Preparar Commit e PR

O agente **prepara**; o humano **executa**. Esta skill nunca roda `add`, `commit`, `push` nem cria PR (ver `.agents/rules/git-workflow.md`).

## Passos

1. **Levante as mudanças.** `git status` e `git diff` (incluindo arquivos novos). Leia o ticket, a sessão e os ADRs relacionados para entender o porquê.
2. **Agrupe em commits coerentes.** Cada grupo é uma mudança que faz sentido sozinha. Separe refatoração de mudança de comportamento. Documentação vai junto do código que ela descreve.
3. **Escreva cada mensagem** seguindo o padrão da rule `git-workflow.md`:
   ```
   tipo(escopo): resumo no imperativo, até ~72 caracteres

   Por que a mudança foi necessária e qualquer efeito não óbvio.

   Refs: tasks/NN, ADR-NNNN
   BREAKING CHANGE: <se houver>
   ```
4. **Se for PR**, preencha `.agents/templates/pull-request.md` com o que mudou, por quê, como testar, riscos e links.
5. **Se for release**, derive as notas da seção "Não lançado" do `CHANGELOG.md`.
6. **Entregue** no formato abaixo. Não execute nenhum dos comandos.

## Formato da entrega

````markdown
### Commit 1 de N
Arquivos:
- caminho/arquivo-a
- caminho/arquivo-b

```
feat(pedidos): rejeita pedido sem itens

Pedidos vazios chegavam ao faturamento e geravam nota com valor zero.

Refs: tasks/07
```

### Commit 2 de N
...

### Comandos sugeridos (para você executar)
```sh
git add caminho/arquivo-a caminho/arquivo-b
git commit -F- <<'MSG'
...
MSG
```
````

## Boas práticas

- O resumo diz **o que muda para quem usa ou mantém**, não "ajustes" ou "correções".
- Mensagem honesta: não diga "testado" se não foi.
- Se as mudanças não couberem em commits coerentes (trabalho misturado), diga isso e sugira como separar.
- Mudança em contrato público ou incompatível precisa de `BREAKING CHANGE:` e entrada destacada no `CHANGELOG.md`.

## Fechamento

- **Registre:** nada novo — os textos vão na resposta para o humano copiar.
- **Atualize:** se notar que o `CHANGELOG.md` não reflete as mudanças, proponha a entrada.
- **Verifique:** toda mudança em `git status` está em algum commit proposto ou explicitamente deixada de fora com motivo.
- **Responda:** a proposta no formato acima e um lembrete de que o commit, o push e o PR são do humano.
