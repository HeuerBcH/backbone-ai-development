---
name: update-progress
description: Atualiza o estado do projeto em docs/progress/STATUS.md e registra a sessão de trabalho em docs/progress/sessions/. Use ao final de toda sessão, ao concluir uma task, quando o usuário disser "encerrar", "salvar progresso", "handoff", ou antes de o contexto da conversa ser perdido.
---

# Atualizar Progresso

O objetivo é que **qualquer agente ou pessoa, começando do zero amanhã, saiba exatamente onde parar e por onde continuar** lendo só o `STATUS.md`.

## Passos

1. Levante o que aconteceu na sessão: pedidos atendidos, tickets tocados, arquivos alterados, decisões, verificações executadas e seus resultados, problemas.
2. Crie `docs/progress/sessions/AAAA-MM-DD-slug.md` a partir de `sessions/_template.md`.
3. Atualize `docs/progress/STATUS.md`: data, itens entre "Em andamento" / "Próximos passos" / "Concluído recentemente", "Bloqueios" e "Ideias e débitos".
4. Se houve correção de rumo ou erro do agente, adicione a lição em `docs/progress/lessons-learned.md`.

## Boas práticas

- Seja factual: o que foi feito, o que foi verificado, o que **não** foi verificado.
- "Concluído recentemente" tem no máximo 10 itens; o histórico completo fica nas sessões.
- O primeiro item de "Próximos passos" deve ser acionável sem perguntar nada a ninguém.

## Fechamento

- **Registre:** sessão nova e `STATUS.md`.
- **Atualize:** confira se `CHANGELOG.md`, `tasks/README.md` e os relatórios em `docs/reports/` refletem o que foi entregue.
- **Verifique:** um leitor sem contexto entende o próximo passo só pelo `STATUS.md`; datas absolutas; nenhuma afirmação de "testado" sem execução real.
- **Responda:** resumo da sessão e o primeiro passo da próxima.
