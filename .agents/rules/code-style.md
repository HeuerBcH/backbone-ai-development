---
description: Padrões de escrita de código — nomenclatura, funções, comentários, erros e logs
always_apply: false
applies_to: ["**/*"]
---

# Estilo de código

Resumo imperativo de `docs/architecture/conventions.md`, que traz exemplos e as escolhas específicas deste projeto. Em conflito, vale o `conventions.md`. Na ausência de uma escolha registrada, siga o padrão idiomático da linguagem e o código vizinho, e proponha registrar a escolha.

## Nomenclatura

- Use a convenção de caixa idiomática da linguagem/ferramenta e a registrada em `conventions.md` §1. Nunca misture convenções no mesmo contexto.
- O nome revela a intenção: quem lê não precisa abrir a implementação para saber o que é.
- Sem abreviações, exceto as consagradas (`id`, `url`, `http`). Nada de `tmp`, `data2`, `x`, `aux` fora de escopos de uma linha.
- Funções e métodos começam com verbo (`calcular_total`, `sendInvoice`). Tipos, classes e módulos são substantivos.
- Booleanos são perguntas: `is_`/`has_`/`can_`/`should_` ou equivalente no idioma do código.
- Coleções no plural, elementos no singular (`for pedido in pedidos`).
- Inclua a unidade quando houver ambiguidade: `timeout_ms`, `tamanho_bytes`, `preco_centavos`.
- Sem números ou textos mágicos: extraia para constantes nomeadas.
- Um conceito tem um nome só em todo o código, e é o termo de `docs/glossary.md`.

## Funções e arquivos

- Uma função faz uma coisa. Se a descrição precisa de "e", divida.
- Poucos parâmetros (até 3). Acima disso, agrupe em uma estrutura nomeada.
- Retorne cedo em vez de aninhar condicionais.
- Sem efeitos colaterais escondidos: se a função altera estado ou faz I/O, o nome deixa isso claro.
- Um arquivo, um conceito principal. Arquivos muito longos são sinal de responsabilidades misturadas.

## Comentários

- O código explica **o quê**; comentários explicam **o porquê**: restrições de negócio, decisões não óbvias, workarounds (com link para ticket ou issue externa).
- Nunca deixe código comentado. O histórico do Git guarda o que foi removido.
- Não comente o óbvio (`// incrementa i`). Se o código precisa de comentário para ser entendido, primeiro tente renomear ou extrair.
- Interfaces públicas (funções exportadas, endpoints, comandos) têm documentação no formato padrão da linguagem.
- `TODO` só com referência a ticket: `TODO(tasks/12): ...`.

## Erros e logs

- Erros são tratados ou propagados explicitamente; nunca engolidos.
- Mensagens de erro dizem o que aconteceu e, quando possível, o que fazer. Não exponha detalhes internos ao usuário final.
- Falhe cedo com entrada inválida, na fronteira do sistema.
- Logs têm nível adequado, contexto suficiente para depurar e nunca contêm segredos ou dados pessoais.

## Formatação

- A formatação é responsabilidade do formatador automático do projeto, não de discussão em review.
