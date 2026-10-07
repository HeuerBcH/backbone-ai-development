---
name: checkup
description: Diagnostica a saúde do projeto ou de uma área (testes, qualidade, dependências, segurança, documentação, processo) e atualiza dependências. Use quando o usuário pedir checkup, auditoria, diagnóstico, "como está o projeto", "verifica se está tudo certo", atualizar dependências ou verificar vulnerabilidades.
---

# Checkup

## Diagnóstico

1. **Escopo:** área pedida ou projeto inteiro. Rode só as dimensões aplicáveis.
2. Para cada dimensão, **com evidência** (comando e resultado, ou `arquivo:linha`):

   | Dimensão | O que verificar |
   | --- | --- |
   | Execução | Instala e roda seguindo `docs/setup.md`? Testes, lint e build passam? |
   | Qualidade | Código comentado, código morto, duplicação, funções ou arquivos enormes, divergência de `conventions.md` |
   | Testes | Áreas críticas sem teste? Testes instáveis? |
   | Dependências | Desatualizadas, vulneráveis, não usadas |
   | Segurança | Segredos no repositório, `.env.example` desatualizado, entradas sem validação |
   | Documentação | Delegue ao subagente `auditor` |
   | Processo | `STATUS.md` reflete a realidade? Bloqueios antigos? |

3. Classifique cada dimensão: OK, ATENÇÃO ou CRÍTICO. Destaque as três prioridades.

Não corrija durante o diagnóstico.

## Atualização de dependências (quando pedido)

1. Priorize: vulnerabilidades → correções → menores → maiores.
2. Versão maior: leia o changelog e o guia de migração antes.
3. Um lote por vez; após cada lote, testes, lint e build. Lockfile atualizado junto.
4. Lote que quebra e não tem correção clara: reverta e registre o bloqueio.
5. Dependência nova ou troca estrutural → `docs/decisions.md`.

## Fechamento

- **Registre:** checkup geral → `docs/reports/AAAA-MM-DD-checkup.md`. Checkup de uma área → a resposta basta, salvo pedido.
- **Atualize:** CRÍTICO → "Próximo" no `STATUS.md`; ATENÇÃO → "Débitos e ideias". Dependências → `CHANGELOG.md` ("Segurança" ou "Alterado").
- **Responda:** resumo por dimensão, três prioridades, o que não foi possível verificar e, se houve atualização, a proposta de commit por lote.
