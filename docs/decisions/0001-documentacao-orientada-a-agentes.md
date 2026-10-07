# 0001 — Adotar documentação e governança orientadas a agentes de IA

**Status:** aceito
**Data:** {{AAAA-MM-DD}}
**Decisores:** {{pessoas}}

## Contexto

O desenvolvimento deste projeto será feito com apoio intenso de agentes de IA. Agentes não guardam memória entre sessões, tendem a supor quando falta contexto e seguem padrões de forma inconsistente se eles não estiverem escritos. Sem um registro estruturado, perde-se o porquê das decisões, o estado atual do trabalho e a padronização do código.

## Alternativas consideradas

### A) Documentação livre, conforme a necessidade

- Prós: nenhum custo inicial.
- Contras: cada sessão recomeça do zero; decisões se perdem; padrões divergem entre sessões e entre pessoas.

### B) Estrutura fixa de documentação + configuração de agentes versionada no repositório

- Prós: contexto reproduzível para qualquer agente ou pessoa; auditoria do que foi feito e por quê; padrões explícitos e verificáveis.
- Contras: exige disciplina para manter os documentos atualizados a cada entrega.

## Decisão

Adotar a alternativa B: `AGENTS.md` como porta de entrada, `.agents/` para rules, skills, subagentes, commands, hooks e MCP, `docs/` para produto, arquitetura, decisões, specs e progresso, e `tasks/` para os tickets.

## Consequências

- **Positivas:** onboarding imediato de agentes e pessoas; rastreabilidade de ideia → requisito → spec → ticket → código; histórico de decisões.
- **Negativas / custos aceitos:** atualizar documentação faz parte da definição de pronto, o que alonga cada entrega.
- **O que precisa mudar:** a rule `documentation.md` e a skill `update-progress` tornam a atualização obrigatória; o subagente `doc-auditor` verifica periodicamente.
