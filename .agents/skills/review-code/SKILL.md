---
name: review-code
description: Revisa código, uma branch, um PR ou um conjunto de arquivos e grava o relatório em docs/reports/reviews/. Use quando o usuário pedir review, revisão, "dá uma olhada no código", "está bom?", "pode mergear?" ou avaliação de qualidade de uma mudança.
---

# Revisar Código

## Quando NÃO usar

- Avaliação do projeto inteiro ou de uma área sem uma mudança específica → `health-check`.

## Passos

1. **Escopo.** Defina o que será revisado: diff da branch atual contra a principal, um PR, um commit ou arquivos indicados. Confirme com o usuário se houver dúvida.
2. **Contexto.** Leia o ticket e a spec da mudança, `docs/architecture/conventions.md`, `docs/architecture/contracts.md` (se tocar interfaces) e as rules aplicáveis.
3. **Verificação executável.** Rode testes, lint e build. Anote os resultados reais.
4. **Revisão.** Delegue ao subagente `code-reviewer`. Se a ferramenta não suportar subagentes, siga o checklist dele diretamente (correção → segurança → testes → padrões → documentação → simplicidade).
5. **Triagem.** Confira cada achado: descarte os que não se sustentam com um cenário concreto. Classifique em CRÍTICO, IMPORTANTE ou SUGESTÃO.
6. **Relatório.** Grave `docs/reports/reviews/AAAA-MM-DD-escopo.md` a partir do template da pasta.
7. **Decisão.** Apresente os achados e pergunte quais corrigir. Não altere código sem autorização.

## Boas práticas

- Todo achado tem arquivo, linha, cenário concreto que causa o problema e sugestão.
- Separe o que bloqueia o merge do que é preferência.
- Revise os testes com o mesmo rigor do código: um teste que passaria com a implementação errada é um achado.
- Não comente formatação que o formatador automático resolve.
- Compare com o padrão do código vizinho, não com uma preferência pessoal.
- Diga também o que foi verificado e está correto, para que o leitor saiba a cobertura da revisão.

## Fechamento

- **Registre:** relatório em `docs/reports/reviews/` e linha no índice `docs/reports/README.md`.
- **Atualize:** achados aceitos e não corrigidos agora viram ticket em `tasks/` ou item em "Ideias e débitos" no `STATUS.md`. Problema recorrente → `lessons-learned.md` ou nova rule.
- **Verifique:** se correções forem aplicadas, rode testes de novo e atualize o relatório com o status de cada achado.
- **Responda:** veredito (aprovado / aprovado com ressalvas / mudanças necessárias), contagem por severidade, link do relatório e o que precisa de decisão do humano.
