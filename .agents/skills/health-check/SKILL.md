---
name: health-check
description: Faz um checkup do projeto inteiro ou de uma área (testes, dependências, segurança, documentação, débitos, processo) e grava o relatório em docs/reports/checkups/. Use quando o usuário pedir checkup, auditoria, diagnóstico, "como está o projeto", "verifica se está tudo certo" ou avaliação de saúde.
---

# Checkup de Saúde

## Quando NÃO usar

- Revisão de uma mudança específica → `review-code`.
- Investigar um bug concreto → `fix-bug`.

## Passos

1. **Escopo.** Se o pedido for de uma área ("checkup dos testes", "da segurança"), rode só as dimensões dela. Se for geral, rode todas.
2. **Linha de base.** Leia o checkup anterior em `docs/reports/checkups/`, se houver, para comparar.
3. **Execute as dimensões aplicáveis**, sempre com evidência (comando executado, arquivo:linha):

   | Dimensão | O que verificar |
   | --- | --- |
   | Build e execução | Projeto instala, compila e sobe seguindo `docs/setup.md` do zero? |
   | Testes | Suíte passa? É determinística? Critérios de aceite dos tickets `done` têm testes? Áreas críticas sem teste? |
   | Qualidade | Lint passa? Código comentado, `TODO` sem ticket, código morto, duplicação, arquivos ou funções muito grandes |
   | Padrões | Código segue `conventions.md`? Padrões divergentes para o mesmo problema? |
   | Dependências | Desatualizadas, vulneráveis, não usadas, sem lockfile |
   | Segurança | Segredos no repositório ou no histórico, `.env.example` atualizado, validação de entradas nas fronteiras |
   | Documentação | Delegue ao subagente `doc-auditor` |
   | Processo | `STATUS.md` atualizado? Tickets parados em `in-progress`? Bloqueios antigos? Sessões registradas? |
   | Operação | `runbook.md` reflete o processo real de implantação e rollback? |

4. **Classifique** cada dimensão: OK, ATENÇÃO ou CRÍTICO, com justificativa.
5. **Relatório.** Grave `docs/reports/checkups/AAAA-MM-DD-escopo.md` a partir do template.

## Boas práticas

- Nenhuma afirmação sem evidência. "Testes OK" exige o comando e o resultado.
- Diga o que **não** foi possível verificar e por quê.
- Priorize: os três problemas mais importantes primeiro, não uma lista plana de cinquenta itens.
- Compare com o checkup anterior: melhorou, piorou ou estagnou?
- Não corrija durante o checkup. Diagnóstico e tratamento são etapas separadas.

## Fechamento

- **Registre:** relatório em `docs/reports/checkups/` e linha no índice `docs/reports/README.md`.
- **Atualize:** cada problema CRÍTICO vira ticket em `tasks/`; problemas ATENÇÃO vão para "Ideias e débitos" no `STATUS.md`.
- **Verifique:** todos os itens do relatório têm evidência.
- **Responda:** resumo por dimensão (OK/ATENÇÃO/CRÍTICO), os três problemas prioritários, tendência em relação ao último checkup e link do relatório.
