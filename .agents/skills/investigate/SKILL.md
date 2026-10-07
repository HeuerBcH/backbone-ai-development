---
name: investigate
description: Investiga uma pergunta técnica ou de produto, compara alternativas e entrega uma recomendação registrada em docs/reports/investigations/. Use quando o usuário pedir para pesquisar, estudar, comparar opções, avaliar viabilidade, fazer um spike, prova de conceito ou "descobrir como funciona" algo.
---

# Investigar

## Passos

1. **Pergunta.** Formule a pergunta exata e os critérios de decisão (custo, desempenho, complexidade, prazo, risco, aderência aos ADRs). Confirme com o usuário.
2. **Contexto interno.** Leia o código, os ADRs e a documentação relacionados. A resposta pode já existir no projeto.
3. **Fontes externas.** Prefira fontes primárias (documentação oficial, especificações, código-fonte). Registre cada fonte com link e data de consulta.
4. **Alternativas.** Compare pelo menos duas opções contra os critérios, incluindo "não fazer nada" quando fizer sentido.
5. **Prova de conceito (se necessário).** Em branch `spike/descricao`, código descartável, nunca mesclado. Registre o que foi medido.
6. **Recomendação.** Uma recomendação clara, com nível de confiança (alta/média/baixa) e o que mudaria a conclusão.
7. **Relatório.** Grave `docs/reports/investigations/AAAA-MM-DD-assunto.md` a partir do template.

## Boas práticas

- Separe fato (com fonte) de opinião (com justificativa).
- Desconfie de fontes desatualizadas; verifique a versão a que a informação se refere.
- Prova de conceito responde uma pergunta específica; não vira produto.
- Se a investigação revelar que a pergunta estava errada, diga isso.

## Fechamento

- **Registre:** relatório em `docs/reports/investigations/` e linha no índice `docs/reports/README.md`.
- **Atualize:** se o humano decidir, skill `record-decision`; perguntas que continuam abertas vão para "Questões em aberto" do PRD ou "Bloqueios" do `STATUS.md`; o que for implementado vira ticket.
- **Verifique:** toda afirmação factual do relatório tem fonte.
- **Responda:** recomendação, confiança, principais trade-offs e link do relatório.
