# Definition of Ready e Definition of Done

Critérios únicos de "pode começar" e "está pronto". Toda skill aponta para este arquivo em vez de repetir os critérios. Um item que não se aplica é marcado como `n/a` com o motivo, nunca ignorado em silêncio.

## Definition of Ready — um ticket pode começar quando

- [ ] Tem objetivo descrito do ponto de vista do comportamento
- [ ] Tem critérios de aceite testáveis
- [ ] Todos os tickets em "Bloqueado por" estão `done`
- [ ] A spec de origem está `ready-for-agent` (ou, para bugs, há passos de reprodução)
- [ ] Não há questão em aberto que mude o resultado esperado

Se algum item falhar, o ticket não começa: registre o motivo em "Bloqueios" no `STATUS.md`.

## Definition of Done — geral (todo pedido que alterou arquivos)

### Qualidade

- [ ] Testes, lint e build executados localmente e passando (comandos em `AGENTS.md`)
- [ ] Código segue `docs/architecture/conventions.md` e as rules aplicáveis
- [ ] Nenhum segredo, dado real, log de depuração ou código comentado foi adicionado
- [ ] Mudança revisada (skill `review-code` ou revisão humana)

### Registro

- [ ] Documentos afetados atualizados conforme `.agents/rules/documentation.md`
- [ ] Decisões com alternativas reais registradas como ADR
- [ ] Sessão registrada em `docs/progress/sessions/` e `STATUS.md` atualizado
- [ ] Proposta de commits entregue ao humano (skill `prepare-commit`), no padrão de `.agents/rules/git-workflow.md` e referenciando o ticket. **O agente não commita.**

### Comunicação

- [ ] Resposta final ao humano diz: o que foi feito, o que foi verificado e como, o que ficou pendente, onde está registrado e a proposta de commits

## Adicionais por tipo de pedido

| Tipo | Critérios extras |
| --- | --- |
| Funcionalidade | Todo critério de aceite do ticket coberto por teste; checkboxes do ticket marcados; `tasks/README.md` atualizado; entrada em `CHANGELOG.md` |
| Bug | Teste que falhava antes da correção; causa raiz escrita no ticket; mesmo padrão de erro procurado em outros pontos; entrada "Corrigido" no `CHANGELOG.md` |
| Refatoração | Nenhum teste existente alterado para passar (exceto renomeações); comportamento externo idêntico; commits propostos separam refatoração de mudança de comportamento |
| Dependências | Changelogs das versões maiores lidos; lockfile atualizado; `docs/setup.md` atualizado se requisitos mudaram |
| Contrato público alterado | `docs/architecture/contracts.md` atualizado; quebra de compatibilidade sinalizada no `CHANGELOG.md` |
| Mudança operacional | `docs/operations/runbook.md` atualizado |
| Review / checkup / investigação | Relatório em `docs/reports/`; achados não resolvidos viraram ticket ou item de "Ideias e débitos" |
