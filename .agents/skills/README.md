# Skills

Uma skill é um **roteiro empacotado de uma atividade** que o agente carrega só quando precisa. É como entregar ao agente o manual de "como fazemos X aqui": os passos, as boas práticas da atividade e o que registrar ao final.

## Como funciona (carregamento progressivo)

1. **Sempre no contexto:** apenas o `name` e a `description` do frontmatter de cada skill.
2. **Quando a tarefa casa com a description:** o agente lê o corpo do `SKILL.md`.
3. **Só se o passo pedir:** o agente abre os arquivos de apoio da pasta (`references/`, `templates/`, `scripts/`).

Por isso dá para ter dezenas de skills sem lotar o contexto, e por isso a `description` é a parte mais importante: ela decide **quando** a skill é usada. A tabela "Roteiro por tipo de pedido" do `AGENTS.md` é o reforço: mesmo que a ferramenta não carregue skills sozinha, o agente sabe qual seguir.

## Estrutura

```
nome-da-skill/
├── SKILL.md         # obrigatório: frontmatter (name, description) + instruções
├── references/      # opcional: documentação detalhada lida sob demanda
├── templates/       # opcional: modelos de saída
└── scripts/         # opcional: código executável que a skill chama
```

## Seções padrão de um SKILL.md

| Seção | Função |
| --- | --- |
| Quando (não) usar | Evita que a skill errada seja aplicada |
| Passos | Roteiro numerado e verificável |
| Boas práticas | Como fazer bem esta atividade e as armadilhas comuns |
| **Fechamento** | **Registre / Atualize / Verifique / Responda** — o que fazer ao terminar, onde gravar cada coisa e o que dizer ao humano |

Copie `_template/` para criar novas skills. Toda skill nova precisa de uma linha na tabela de roteiro do `AGENTS.md`.

## Skills deste projeto

| Skill | Atividade | Registro principal |
| --- | --- | --- |
| `write-prd` | Definir produto e requisitos | `docs/product/` |
| `write-spec` | Especificar uma etapa | `docs/specs/` |
| `spec-to-tasks` | Quebrar spec em tickets | `tasks/` |
| `execute-task` | Implementar funcionalidade | ticket + sessão |
| `fix-bug` | Corrigir bug | ticket de bug + CHANGELOG |
| `review-code` | Revisar mudança | `docs/reports/reviews/` |
| `health-check` | Checkup do projeto ou de uma área | `docs/reports/checkups/` |
| `refactor` | Melhorar estrutura sem mudar comportamento | sessão |
| `investigate` | Pesquisar, comparar, prova de conceito | `docs/reports/investigations/` |
| `update-dependencies` | Atualizar ou adicionar dependências | CHANGELOG + sessão |
| `handle-incident` | Responder a incidente em produção | `docs/operations/postmortems/` |
| `prepare-commit` | Preparar commits, descrição de PR e notas de release para o humano executar | resposta |
| `record-decision` | Registrar decisão | `docs/decisions/` |
| `update-progress` | Encerrar sessão | `docs/progress/` |

## Skills de terceiros

Skills de boas práticas de tecnologias específicas podem ser instaladas na mesma pasta (ex.: `npx skills add <org>/<repo>`). O lockfile `skills-lock.json` registra origem e hash de cada uma. Não edite skills de terceiros à mão: atualize pela ferramenta.
