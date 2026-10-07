# Visão geral da arquitetura

**Última atualização:** {{AAAA-MM-DD}}

## 1. Contexto

<!-- O sistema e tudo com que ele conversa: usuários, sistemas externos, integrações. Um diagrama de contexto ajuda. -->

```mermaid
flowchart LR
  usuario([Usuário]) --> sistema[{{Sistema}}]
  sistema --> externo[(Sistema externo)]
```

## 2. Componentes

| Componente | Responsabilidade | Onde fica no repositório |
| --- | --- | --- |
| | | |

## 3. Estrutura de pastas do código

```
<!-- árvore das pastas principais com uma linha explicando cada uma -->
```

## 4. Fluxo de dados

<!-- Como uma requisição/evento típico atravessa os componentes. -->

## 5. Dados e persistência

<!-- Onde os dados vivem e quem é dono de cada dado. Entidades, estados e invariantes ficam em domain-model.md. -->

## 6. Integrações externas

Resumo. O detalhe de cada interface fica em [`contracts.md`](contracts.md).

| Integração | Para quê | Protocolo | Falha esperada e tratamento |
| --- | --- | --- | --- |
| | | | |

## 7. Aspectos transversais

- **Autenticação e autorização:**
- **Tratamento de erros:**
- **Logs e observabilidade:**
- **Configuração e segredos:**
- **Testes (níveis e seams):**

## 8. Ambientes e implantação

| Ambiente | Para quê | Como implantar |
| --- | --- | --- |
| | | |

## 9. Decisões relacionadas

<!-- Links para os ADRs que moldaram esta arquitetura. -->
