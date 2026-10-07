---
description: Mantém a documentação sincronizada com o código e o estado do projeto
always_apply: true
applies_to: ["**/*"]
---

# Documentação

A documentação é parte da entrega, não um extra. Uma tarefa que muda o comportamento e não atualiza os documentos afetados **não está concluída** (ver `docs/process/definition-of-done.md`).

| Se você... | Atualize |
| --- | --- |
| Concluiu ou avançou um ticket | Checkboxes do ticket em `tasks/`, quadro em `tasks/README.md` e `docs/progress/STATUS.md` |
| Tomou uma decisão com alternativas reais | Novo ADR em `docs/decisions/` |
| Mudou um padrão de código ou estrutura | `docs/architecture/conventions.md` e a rule correspondente |
| Mudou componentes, integrações ou fluxo de dados | `docs/architecture/overview.md` |
| Criou ou mudou entidade, estado ou invariante do domínio | `docs/architecture/domain-model.md` |
| Criou ou mudou interface pública (API, evento, comando, formato de arquivo) | `docs/architecture/contracts.md` |
| Introduziu um termo de domínio | `docs/glossary.md` |
| Adicionou ou mudou variável de ambiente ou pré-requisito | `docs/setup.md` e `.env.example` |
| Mudou implantação, configuração de ambiente ou procedimento operacional | `docs/operations/runbook.md` |
| Mudou algo visível para o usuário | `CHANGELOG.md`, seção "Não lançado" |
| Mudou comandos de build/teste/execução | Tabela de comandos em `AGENTS.md` |
| Fez review, checkup ou investigação | Relatório em `docs/reports/` |
| Errou e foi corrigido, ou descobriu algo não óbvio | `docs/progress/lessons-learned.md` |
| Encerrou uma sessão de trabalho | Novo registro em `docs/progress/sessions/` |

- Datas sempre absolutas (`2026-10-06`), nunca "ontem" ou "semana passada".
- Use links relativos entre documentos para que a navegação funcione no repositório.
- Não duplique informação: se já existe em outro documento, aponte para ele.
- Ao criar um documento em uma pasta com índice (`README.md`), atualize o índice.
