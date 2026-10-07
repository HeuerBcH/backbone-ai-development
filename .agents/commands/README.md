# Commands

Commands (também chamados de *slash commands*, *prompts* ou *workflows*, dependendo da ferramenta) são **prompts prontos que o humano dispara pelo nome**, como `/start-session`. Evitam reescrever o mesmo pedido longo toda vez e garantem que todos do time peçam do mesmo jeito.

## Command vs. Skill

| | Command | Skill |
| --- | --- | --- |
| Quem dispara | O humano, explicitamente | O agente, quando o pedido casa com a description ou com o roteiro do `AGENTS.md` |
| Papel | Atalho para iniciar um fluxo | Roteiro completo de uma atividade |
| Típico | Orquestra skills e subagentes | Faz uma atividade do início ao fechamento |

Os commands são atalhos: pedir em linguagem natural ("revisa meu código") leva à mesma skill pelo roteiro do `AGENTS.md`.

## Formato

```yaml
---
description: O que o command faz (aparece na lista de comandos)
argument-hint: <argumento esperado>
---
Instruções. Use $ARGUMENTS para o texto digitado depois do nome do comando.
```

## Commands deste projeto

| Command | O que faz |
| --- | --- |
| `/start-session` | Carrega o contexto e propõe o próximo passo |
| `/end-session` | Fecha a sessão registrando o progresso |
| `/new-feature` | Leva uma ideia até specs e tickets |
| `/fix` | Corrige um bug com a skill `fix-bug` |
| `/review` | Revisa a mudança atual com a skill `review-code` |
| `/checkup` | Checkup do projeto ou de uma área com a skill `health-check` |
| `/commit-msg` | Prepara commits e descrição de PR para você executar |
| `/audit-docs` | Verifica se a documentação está fiel ao código |
