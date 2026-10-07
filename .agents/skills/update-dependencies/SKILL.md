---
name: update-dependencies
description: Atualiza dependências existentes ou avalia e adiciona dependências novas com segurança, em lotes pequenos e testados. Use quando o usuário pedir para atualizar pacotes, bibliotecas, versões, corrigir vulnerabilidades de dependências ou adicionar uma biblioteca nova.
---

# Atualizar Dependências

## Passos — atualizar existentes

1. **Inventário.** Rode o comando de dependências desatualizadas/vulneráveis do `AGENTS.md`. Liste nome, versão atual, versão alvo e tipo de salto (correção, menor, maior).
2. **Priorize:** vulnerabilidades primeiro, depois saltos de correção, depois menores, por último maiores.
3. **Saltos maiores:** leia o changelog e o guia de migração de cada versão intermediária. Liste as quebras que afetam o projeto.
4. **Lotes pequenos.** Atualize um lote por vez (todas as correções juntas; cada versão maior sozinha). Após cada lote: instalar, testes, lint, build. A cada lote verde, pare e entregue ao humano a proposta de commit do lote (skill `prepare-commit`).
5. **Falhou?** Corrija se a migração for clara; senão, reverta o lote e registre o bloqueio.

## Passos — adicionar nova

1. Confirme que o projeto não tem algo que já resolve o problema.
2. Avalie: manutenção ativa, licença compatível, tamanho/impacto, segurança, popularidade, **nome exato** (pacotes com nome parecido são vetor de ataque).
3. Compare com pelo menos uma alternativa (inclusive implementar internamente).
4. Dependência estrutural → skill `record-decision` antes de adicionar.

## Boas práticas

- Lockfile sempre versionado e atualizado junto.
- Nunca atualize tudo de uma vez: quando quebra, não se sabe o culpado.
- Não aceite versões pré-lançamento sem decisão explícita.

## Fechamento

- **Registre:** sessão em `docs/progress/sessions/` com a tabela antes → depois.
- **Atualize:** `CHANGELOG.md` ("Segurança" para vulnerabilidades, "Alterado" para o resto); `docs/setup.md` se mudaram pré-requisitos; ADR para adição ou troca estrutural; `STATUS.md` com os lotes bloqueados.
- **Verifique:** Definition of Done geral + adicionais de "Dependências".
- **Responda:** o que foi atualizado, o que ficou para trás e por quê, vulnerabilidades restantes e a proposta de commits por lote.
