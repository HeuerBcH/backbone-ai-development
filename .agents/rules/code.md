---
description: Como escrever código — nomes, funções, comentários, erros, design e testes
always_apply: false
applies_to: ["**/*"]
---

# Código

Princípios universais. As escolhas específicas do projeto (caixa de nomes, camadas, patterns adotados, ferramentas) estão em `docs/conventions.md` e prevalecem. Sem escolha registrada: siga o idioma da linguagem e o código vizinho.

## Nomes

- O nome revela a intenção. Sem abreviações além das consagradas (`id`, `url`).
- Funções começam com verbo; tipos e módulos são substantivos; booleanos são perguntas (`is_`, `has_`, `can_`).
- Coleções no plural; unidade no nome quando ambíguo (`timeout_ms`).
- Constantes nomeadas no lugar de valores mágicos.
- Um conceito, um nome — o do glossário em `docs/product.md`.

## Funções e comentários

- Uma função faz uma coisa; até 3 parâmetros; retorne cedo em vez de aninhar.
- Comentário explica o **porquê** (regra de negócio, restrição, workaround com link), nunca o óbvio.
- Nunca deixe código comentado. `TODO` só com referência rastreável.
- Interfaces públicas documentadas no formato padrão da linguagem.

## Erros e logs

- Erros são tratados onde há algo útil a fazer ou propagados; nunca engolidos.
- Mensagem ao usuário é compreensível; detalhe técnico vai para o log.
- Logs nunca contêm segredos ou dados pessoais.

## Design

- A solução mais simples que funciona e é testável. Nada para requisitos hipotéticos.
- Abstraia na terceira repetição, não na primeira.
- Design pattern só quando resolve um problema presente; reutilize o que o projeto já adotou para o mesmo problema (`docs/conventions.md`). Pattern novo e estrutural → `docs/decisions.md`.
- Regra de negócio separada de I/O (banco, rede, arquivos, interface). Integrações externas atrás de uma interface.
- Composição em vez de herança; prefira dados imutáveis.

## Testes

- Teste comportamento observável, não implementação.
- Mudança de comportamento sem teste não está pronta. Bug corrigido ganha teste que falhava antes.
- Testes determinísticos e independentes; mock só do que está fora do controle do projeto.
- Nunca altere um teste só para fazê-lo passar sem entender por que falhava.
- Formatação é do formatador automático, não de discussão.
