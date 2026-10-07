---
name: review
description: Revisa código, uma branch, um PR ou um conjunto de arquivos e devolve achados por severidade. Use quando o usuário pedir review, revisão, "dá uma olhada", "está bom?", "pode mergear?" ou avaliação de uma mudança.
---

# Revisar

## Passos

1. **Escopo:** diff da branch atual contra a principal, ou o que o usuário indicar.
2. **Contexto:** o pedido ou a spec da mudança, `docs/conventions.md`, contratos em `docs/architecture.md` se forem tocados.
3. **Execute** testes, lint e build e anote os resultados reais.
4. **Revise** na ordem: correção → segurança → contratos e dados → testes → design → estilo → documentação. Diff grande ou nível Grande: delegue ao subagente `reviewer`.
5. **Filtre:** só fica o achado que você justifica com um cenário concreto.

## Formato

```
[CRÍTICO | IMPORTANTE | SUGESTÃO] arquivo:linha — problema
Cenário: situação concreta que causa o problema
Sugestão: como corrigir
```

Termine com: o que foi verificado e está correto, o que não foi verificado e o veredito (aprovado / com ressalvas / mudanças necessárias).

## Boas práticas

- Separe o que bloqueia do que é preferência.
- Revise os testes com o mesmo rigor: teste que passaria com código errado é achado.
- Não comente formatação que o formatador resolve.

## Fechamento

- **Registre:** nível Grande ou a pedido → salve em `docs/reports/AAAA-MM-DD-review-escopo.md`. Caso contrário, a resposta basta.
- **Atualize:** achados aceitos e não corrigidos agora → "Débitos e ideias" no `STATUS.md`.
- **Responda:** achados, veredito e pergunte quais corrigir. Não corrija sem autorização.
