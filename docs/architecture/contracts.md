# Contratos e interfaces públicas

Toda fronteira em que algo de fora depende deste sistema, ou em que este sistema depende de algo de fora. Mudar um contrato pode quebrar quem o consome; por isso toda mudança aqui é deliberada, documentada e sinalizada no `CHANGELOG.md`.

Exemplos de contrato: API, eventos/mensagens publicados, comandos de linha de comando, formato de arquivo importado/exportado, interface de uma biblioteca, esquema compartilhado, webhooks.

**Última atualização:** {{AAAA-MM-DD}}

## 1. Política de compatibilidade

- **Versionamento:** {{como as versões do contrato são identificadas}}
- **Mudança compatível** (adicionar campo opcional, novo recurso): permitida, registrada no CHANGELOG.
- **Mudança incompatível** (remover, renomear, mudar tipo ou significado): exige ADR, nova versão ou período de transição, e entrada destacada no CHANGELOG.
- **Fonte de verdade da especificação:** {{este documento / arquivo de especificação formal / código}}

## 2. Contratos expostos (outros dependem de nós)

### {{Nome do contrato}}

| Campo | Valor |
| --- | --- |
| Tipo | {{API / evento / CLI / arquivo / biblioteca}} |
| Consumidores | {{quem usa}} |
| Autenticação / autorização | {{}} |
| Versão atual | {{}} |

**Operações:**

| Operação | Entrada | Saída de sucesso | Erros possíveis |
| --- | --- | --- | --- |
| | | | |

## 3. Contratos consumidos (nós dependemos de outros)

| Sistema | O que usamos | Onde está isolado no código | Comportamento em falha |
| --- | --- | --- | --- |
| | | {{adapter/módulo}} | {{retentativa / degradação / erro}} |

## 4. Formato padrão de erro

<!-- Estrutura única de erro exposta para fora: código, mensagem, detalhes. -->
