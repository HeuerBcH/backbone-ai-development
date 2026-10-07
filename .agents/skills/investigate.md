---
name: investigate
description: Investiga uma pergunta técnica ou de produto, compara alternativas e recomenda. Use quando o usuário pedir para pesquisar, estudar, comparar opções, escolher tecnologia, avaliar viabilidade, fazer prova de conceito ou entender como algo funciona.
---

# Investigar

## Passos

1. **Pergunta e critérios.** Formule a pergunta exata e o que decide a escolha (custo, complexidade, desempenho, prazo, risco, aderência às decisões existentes).
2. **O projeto primeiro.** Código, `docs/decisions.md` e `docs/architecture.md` podem já responder.
3. **Fontes primárias:** documentação oficial, especificações, código-fonte. Guarde link e data.
4. **Compare** pelo menos duas opções contra os critérios.
5. **Prova de conceito**, se necessária: branch `spike/assunto`, descartável, nunca integrada.
6. **Recomende** com nível de confiança (alta/média/baixa) e o que mudaria a conclusão.

## Boas práticas

- Separe fato (com fonte) de opinião (com justificativa).
- Verifique a que versão a informação se refere.
- Se a pergunta estava errada, diga.

## Fechamento

- **Registre:** nível Grande ou a pedido → `docs/reports/AAAA-MM-DD-investigacao-assunto.md`. Se o usuário decidir → entrada em `docs/decisions.md`.
- **Responda:** recomendação, confiança, trade-offs e fontes.
