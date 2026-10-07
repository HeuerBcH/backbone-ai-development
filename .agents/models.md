# Matriz de modelos

Registro de **qual modelo/ferramenta o time usa para cada tipo de trabalho** e por quê. Atualize quando trocar; mudanças grandes merecem um ADR.

| Tipo de trabalho | Modelo / ferramenta | Por quê |
| --- | --- | --- |
| Descoberta, PRD, decisões de arquitetura | {{modelo de maior capacidade de raciocínio}} | Erros aqui se propagam para tudo; vale pagar mais |
| Specs e quebra em tasks | {{modelo}} | Precisa de visão do todo e consistência |
| Implementação de task bem especificada | {{modelo rápido/econômico}} | A spec já reduziu a ambiguidade |
| Revisão de código | {{modelo diferente do que implementou}} | Um segundo olhar com outro viés encontra mais problemas |
| Tarefas mecânicas (renomear, formatar, migrar padrões) | {{modelo pequeno}} | Custo e velocidade |
| Geração de imagens / UI / diagramas | {{ferramenta}} | |

## Princípios

- **Planeje com o modelo forte, execute com o rápido.** A qualidade do plano limita a qualidade do resultado.
- **Contexto vale mais que modelo.** Um modelo mediano com spec clara supera um modelo de ponta com pedido vago.
- **Registre o modelo nas sessões** (`docs/progress/sessions/`) para conseguir comparar resultados depois.
