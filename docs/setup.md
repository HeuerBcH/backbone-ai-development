# Setup do ambiente

Como sair de uma máquina vazia até o projeto rodando e testado. Se algum passo falhar, corrija este documento junto com a solução.

## 1. Pré-requisitos

| Ferramenta | Versão | Para quê | Como verificar |
| --- | --- | --- | --- |
| {{ferramenta}} | {{versão}} | {{}} | `{{comando --version}}` |

## 2. Primeira execução

```sh
# 1. Clonar
git clone {{url}}
cd {{pasta}}

# 2. Variáveis de ambiente
cp .env.example .env    # depois preencha os valores (seção 3)

# 3. Dependências
{{comando}}

# 4. Serviços auxiliares (banco, filas, etc.), se houver
{{comando}}

# 5. Rodar
{{comando}}

# 6. Testar
{{comando}}
```

**Resultado esperado:** {{como saber que funcionou — URL, saída no terminal, etc.}}

## 3. Variáveis de ambiente

Toda variável usada pelo projeto está aqui e em `.env.example` (sem valores reais).

| Variável | Obrigatória | Descrição | Exemplo / formato | Onde obter |
| --- | --- | --- | --- | --- |
| `{{NOME}}` | sim / não | {{}} | {{}} | {{}} |

## 4. Serviços externos

| Serviço | Para quê | Ambiente local | Credenciais |
| --- | --- | --- | --- |
| | | {{real / emulado / mock}} | {{variável}} |

## 5. Problemas comuns

| Sintoma | Causa | Solução |
| --- | --- | --- |
| | | |
