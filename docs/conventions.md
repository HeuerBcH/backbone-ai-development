# Convenções do projeto

As **escolhas específicas** deste projeto. Os princípios universais (nomes, funções, comentários, erros, design, testes) estão em [`.agents/rules/code.md`](../.agents/rules/code.md) e não se repetem aqui. Preencha quando as tecnologias forem escolhidas; mude junto com o código, nunca depois.

## Nomenclatura

Siga a convenção idiomática de cada linguagem e registre:

| Elemento | Padrão | Exemplo |
| --- | --- | --- |
| Arquivos e pastas | {{}} | |
| Tipos / classes | {{}} | |
| Funções / métodos | {{}} | |
| Variáveis e constantes | {{}} | |
| Testes | {{}} | |
| Tabelas, colunas, chaves de configuração | {{}} | |
| Branches | `tipo/descricao-curta` | `feat/enviar-evidencia` |

**Idioma dos identificadores:** {{português / inglês}}

## Ferramentas e estrutura

| Assunto | Escolha |
| --- | --- |
| Camadas e onde fica cada tipo de código | ver `architecture.md` §1 |
| Representação de erros | {{ex.: exceções tipadas, tipo Result}} |
| Validação de entrada | {{}} |
| Testes (unidade / integração / ponta a ponta) | {{ferramentas e onde ficam}} |
| Logs | {{formato e ferramenta}} |
| Documentação de interfaces públicas | {{ex.: docstring, JSDoc}} |

## Patterns adotados

Antes de introduzir um pattern, veja se o problema já tem um aqui. Reutilize.

| Problema | Pattern | Onde | Decisão |
| --- | --- | --- | --- |
| {{ex.: isolar acesso a dados}} | {{ex.: Repository}} | | D-NNN |

## Proibido neste projeto

| Não faça | Faça em vez disso |
| --- | --- |
| | |
