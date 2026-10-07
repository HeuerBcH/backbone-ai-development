---
name: handle-incident
description: Conduz a resposta a um incidente em produção — estabilizar, registrar a linha do tempo, corrigir a causa e escrever o postmortem. Use quando o usuário relatar sistema fora do ar, erro afetando usuários reais, perda ou corrupção de dados, degradação grave ou alerta de produção.
---

# Responder a Incidente

## Passos

1. **Estabilize primeiro, investigue depois.** Consulte `docs/operations/runbook.md` (rollback, desativar funcionalidade, escalar). Toda ação em produção exige confirmação humana explícita.
2. **Linha do tempo.** Desde o início, anote com horário: sintomas, ações tomadas, resultados. Não confie na memória.
3. **Comunicação.** Lembre o humano de avisar os afetados conforme o runbook.
4. **Confirme a estabilização** com evidência (métrica, log, teste manual).
5. **Causa raiz.** Com o sistema estável, siga a skill `fix-bug` para a correção definitiva.
6. **Postmortem.** Escreva `docs/operations/postmortems/AAAA-MM-DD-titulo.md` a partir do template.

## Boas práticas

- Restaurar o serviço vale mais que entender o problema durante o incidente.
- Uma pessoa coordena; mudanças em produção são feitas uma de cada vez e anotadas.
- Postmortem sem culpados: procure falhas de processo e de sistema, não de pessoas.
- Cada ação corretiva do postmortem tem dono e ticket.

## Fechamento

- **Registre:** postmortem em `docs/operations/postmortems/`; sessão em `docs/progress/sessions/`.
- **Atualize:** `runbook.md` com qualquer procedimento que faltou ou estava errado; tickets das ações corretivas; `lessons-learned.md`; `CHANGELOG.md` com a correção.
- **Verifique:** serviço estável com evidência; ações corretivas com dono.
- **Responda:** estado atual, impacto, causa raiz, ações corretivas e link do postmortem.
