# Arquitetura

**Atualizado em:** {{AAAA-MM-DD}}

O **como**: componentes, regras do domínio e contratos. Quando uma seção passar de ~300 linhas, mova-a para `docs/architecture/<secao>.md` e deixe um link.

## 1. Visão geral

```mermaid
flowchart LR
  usuario([Usuário]) --> sistema[{{Sistema}}]
  sistema --> externo[(Sistema externo)]
```

| Componente | Responsabilidade | Onde fica |
| --- | --- | --- |
| | | |

**Estrutura de pastas:**

```
<!-- pastas principais com uma linha cada -->
```

**Direção das dependências:** {{ex.: interface → aplicação → domínio ← infraestrutura}}

## 2. Domínio

Entidades, estados e regras que nunca podem ser violadas. É o que faz o agente entender o negócio.

| Entidade | O que é | Estados | Relações |
| --- | --- | --- | --- |
| | | | |

**Invariantes** (verdadeiras sempre; cada uma tem teste):

| ID | Invariante | Onde é garantida |
| --- | --- | --- |
| INV-01 | | |

**Operações que precisam ser atômicas:** <!-- operações que alteram várias entidades juntas -->

## 3. Contratos

Fronteiras de que outros dependem ou de que dependemos. Mudança incompatível exige registro em `decisions.md`, sinalização no `CHANGELOG.md` e plano de transição.

**Expostos** (API, eventos, CLI, arquivos, webhooks):

| Contrato | Tipo | Consumidores | Versão |
| --- | --- | --- | --- |
| | | | |

**Consumidos:**

| Sistema | O que usamos | Isolado em | Se falhar |
| --- | --- | --- | --- |
| | | | |

**Formato padrão de erro:** <!-- estrutura única de erro exposta para fora -->

## 4. Aspectos transversais

- **Autenticação e autorização:**
- **Configuração e segredos:** ver `setup.md`
- **Logs e observabilidade:**
- **Ambientes e implantação:** ver `operations.md`
