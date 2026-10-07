# Subagents

Um subagente é um **agente especializado que o agente principal chama para uma tarefa isolada**. Ele roda com contexto próprio e limpo, faz o trabalho e devolve só o resultado.

## Por que usar

- **Contexto limpo:** a sessão principal não se enche com dezenas de arquivos lidos durante uma revisão ou pesquisa.
- **Especialização:** cada subagente tem instruções, tools e até modelo próprios, focados em uma função.
- **Olhar independente:** um revisor que não escreveu o código não herda os vieses de quem escreveu.
- **Paralelismo:** várias investigações independentes podem rodar ao mesmo tempo.

## Formato

```yaml
---
name: nome-do-agente
description: Quando o agente principal deve delegar para este subagente
tools: [read, search, bash]     # menor conjunto necessário
model: {{modelo}}               # opcional; veja .agents/models.md
---
<prompt de sistema do subagente>
```

## Subagents deste projeto

| Agente | Função | Escreve arquivos? |
| --- | --- | --- |
| `planner` | Transforma um pedido em plano de implementação | Não |
| `code-reviewer` | Revisa mudanças contra specs, convenções e rules | Não |
| `doc-auditor` | Verifica se a documentação reflete o código e o estado real | Não |

Subagentes de leitura nunca alteram arquivos: devolvem achados para o agente principal decidir. Copie `_template.md` para criar novos.
