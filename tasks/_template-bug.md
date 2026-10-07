# NN: Bug — {{descrição curta do comportamento errado}}

**Status:** ready-for-agent
**Severidade:** crítica | alta | média | baixa
**Origem:** {{relato do usuário / review / checkup / incidente}}
**Spec / requisito afetado:** <!-- link, RF ou US -->

## Reprodução

**Ambiente:** {{local / homologação / produção, versão}}

1. 
2. 

**Esperado:** <!-- com referência ao requisito, se houver -->
**Atual:** <!-- incluindo mensagem de erro e trecho relevante do log -->

## Investigação

| Hipótese | Como foi testada | Resultado |
| --- | --- | --- |
| | | confirmada / descartada |

**Causa raiz:** <!-- preenchido ao concluir -->

## Critérios de aceite

- [ ] Teste de regressão que falhava antes da correção agora passa
- [ ] Causa raiz corrigida (não apenas o sintoma)
- [ ] Mesmo padrão de erro procurado em outros pontos do código
- [ ] Entrada "Corrigido" no `CHANGELOG.md`
