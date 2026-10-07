# Convenções e padrões de projeto

Este documento é o **contrato de padrões** do código. Ele tem duas camadas:

- **Princípios** (já preenchidos): valem para todo projeto e raramente mudam.
- **Decisões do projeto** (`{{...}}`): escolhas que dependem das tecnologias adotadas. Preencha no início do projeto e sempre que uma nova escolha for feita.

Toda mudança de padrão altera este arquivo no mesmo commit. A versão resumida para agentes fica em [`.agents/rules/code-style.md`](../../.agents/rules/code-style.md) e [`.agents/rules/design.md`](../../.agents/rules/design.md).

## 1. Nomenclatura

### Princípios

- O nome revela a intenção; sem abreviações além das consagradas (`id`, `url`).
- Funções e métodos começam com verbo; tipos e módulos são substantivos.
- Booleanos são perguntas (`is_`/`has_`/`can_`/`should_` ou equivalente no idioma do código).
- Coleções no plural, elementos no singular.
- Unidade no nome quando houver ambiguidade (`timeout_ms`, `tamanho_bytes`).
- Constantes nomeadas no lugar de valores mágicos.
- Um conceito, um nome, igual ao de [`../glossary.md`](../glossary.md).

### Decisões do projeto

Siga a convenção idiomática de cada linguagem/ferramenta e registre-a aqui:

| Elemento | Padrão | Exemplo |
| --- | --- | --- |
| Arquivos de código | {{ex.: kebab-case, snake_case, PascalCase}} | |
| Pastas | {{}} | |
| Tipos / classes / interfaces | {{}} | |
| Funções / métodos | {{}} | |
| Variáveis e parâmetros | {{}} | |
| Constantes | {{}} | |
| Testes (arquivos e casos) | {{}} | |
| Tabelas, colunas, chaves de configuração | {{}} | |
| Branches e commits | ver [`.agents/rules/git-workflow.md`](../../.agents/rules/git-workflow.md) | `feat/03-enviar-evidencia` |

**Idioma dos identificadores:** {{português / inglês}}. Termos do domínio seguem o glossário.

## 2. Organização do código

### Princípios

- Regra de negócio separada de I/O (banco, rede, arquivos, interface).
- Dependências apontam para o domínio, nunca do domínio para a infraestrutura.
- Código agrupado por funcionalidade/domínio, não apenas por tipo técnico, quando o projeto crescer.

### Decisões do projeto

- **Camadas e direção de dependências:** {{ex.: interface → aplicação → domínio ← infraestrutura}}
- **Onde fica cada tipo de código:** ver [`overview.md`](overview.md) §3.

## 3. Design patterns adotados

Patterns são usados quando resolvem um problema presente, nunca por padrão. Antes de introduzir um, verifique esta tabela: se o problema já tem um pattern adotado, reutilize-o. Pattern novo e estrutural exige ADR.

| Problema | Pattern adotado | Onde é usado | ADR |
| --- | --- | --- | --- |
| {{ex.: isolar acesso a dados}} | {{ex.: Repository}} | | |

## 4. Funções e comentários

- Uma responsabilidade por função; até 3 parâmetros; retorno cedo.
- Comentários explicam o porquê; nunca código comentado; `TODO` só com ticket.
- Interfaces públicas documentadas no formato padrão da linguagem: {{ex.: docstring, JSDoc, KDoc, XML doc}}.

## 5. Tratamento de erros

### Princípios

- Erros nunca são engolidos; são tratados onde há algo útil a fazer ou propagados.
- Erros esperados do domínio são distintos de falhas inesperadas.
- O usuário final recebe mensagem compreensível; detalhes técnicos vão para o log.

### Decisões do projeto

- **Representação de erros:** {{ex.: exceções tipadas, tipo Result, códigos de erro}}
- **Formato de erro exposto para fora:** ver [`contracts.md`](contracts.md).

## 6. Validação de dados

- Toda entrada externa é validada na fronteira; dentro do domínio, os dados já são confiáveis.
- **Mecanismo de validação:** {{}}

## 7. Testes

### Princípios

- Testar comportamento observável, não implementação.
- Testes determinísticos e independentes.
- Mock apenas do que está fora do controle do projeto (rede, relógio, serviços externos).

### Decisões do projeto

| Nível | Ferramenta | Onde ficam | O que cobre |
| --- | --- | --- | --- |
| Unidade | {{}} | {{}} | Regras de domínio |
| Integração | {{}} | {{}} | Fronteiras com banco, rede, arquivos |
| Ponta a ponta | {{}} | {{}} | Fluxos críticos do usuário |

## 8. Logs e observabilidade

- Níveis: `erro` (exige ação), `aviso` (anormal, mas tratado), `info` (eventos de negócio), `debug` (desenvolvimento).
- Nunca logar segredos ou dados pessoais.
- **Formato e ferramenta:** {{ex.: logs estruturados em JSON}}

## 9. Dependências

- Antes de adicionar: é mantida? licença compatível? o projeto já tem algo que resolve? o nome está correto?
- Versões fixadas por lockfile versionado.
- Dependência estrutural (framework, banco, biblioteca central) exige ADR.

## 10. Anti-padrões proibidos

| Não faça | Por quê | Faça em vez disso |
| --- | --- | --- |
| Código comentado | Polui e desatualiza; o Git guarda o histórico | Apague |
| Capturar erro e não fazer nada | Esconde falhas e corrompe estado | Trate ou propague |
| Abstração antes da terceira repetição | Abstração errada custa mais que duplicação | Duplique e abstraia quando o padrão ficar claro |
| Pattern sem problema concreto | Complexidade sem benefício | Solução direta; pattern quando a necessidade surgir |
| Valores mágicos | Significado escondido, mudança espalhada | Constante nomeada |
| Lógica de negócio misturada com I/O | Difícil de testar e de mudar | Separe domínio e infraestrutura |
| Estado global mutável | Acoplamento oculto e bugs de concorrência | Passe dependências explicitamente |
| {{anti-padrão específico do projeto}} | | |
