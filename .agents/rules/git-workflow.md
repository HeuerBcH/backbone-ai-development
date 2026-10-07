---
description: Divisão de responsabilidades no Git — o humano versiona, o agente prepara
always_apply: true
applies_to: ["**/*"]
---

# Fluxo Git

## O que é exclusivo do humano

O agente **nunca** executa operações que gravam histórico, publicam código ou integram mudanças. Isso inclui, sem exceção:

- `commit` (inclusive `--amend`), `revert`, `cherry-pick`, `merge`, `rebase`, `tag`, `am`
- `add` / stage — o humano escolhe o que entra em cada commit; o agente sugere o agrupamento
- `push` de qualquer tipo
- Criar, aprovar, mesclar ou fechar pull requests / merge requests, e criar releases, por CLI, API ou MCP
- `reset --hard`, `clean -f`, `stash drop` e qualquer comando que descarte trabalho

Se o humano pedir explicitamente uma dessas operações, responda com o comando pronto para **ele** executar. O hook `guard-command.sh` bloqueia essas operações de forma determinística.

**Por quê:** o commit é o registro auditável de quem aprovou cada mudança. Quem assina a mudança precisa ser quem a revisou e decidiu publicá-la.

## O que o agente pode fazer no Git

- Ler o estado: `status`, `diff`, `log`, `show`, `blame`, `branch --list`.
- Criar e trocar de branch local (`switch -c`), seguindo o padrão de nome abaixo.
- Preparar textos: mensagem de commit, agrupamento de arquivos por commit, descrição de PR, notas de release (skill `prepare-commit`).

## Padrões que o agente usa ao preparar textos

- **Branch:** `tipo/NN-descricao-curta` (ex.: `feat/03-enviar-evidencia`).
- **Mensagem de commit:** [Conventional Commits](https://www.conventionalcommits.org/pt-br/) — `tipo(escopo opcional): resumo no imperativo`, com `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, `perf`, `build`, `ci`. Corpo explica o porquê quando não for óbvio. Rodapé referencia ticket/ADR e sinaliza `BREAKING CHANGE:` quando houver.
- **Granularidade:** um commit = uma mudança coerente. Código e documentação da mesma mudança vão juntos; refatoração e mudança de comportamento vão separadas.
- **Descrição de PR:** segue `.agents/templates/pull-request.md`.

## Ao terminar um trabalho que alterou arquivos

Entregue ao humano uma **proposta de commit**: arquivos agrupados por commit e a mensagem de cada um, prontos para copiar. O humano revisa, commita e publica.
