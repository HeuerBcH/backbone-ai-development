---
description: Princípios de design de software — simplicidade, design patterns, acoplamento e fronteiras
always_apply: false
applies_to: ["**/*"]
---

# Design

## Simplicidade primeiro

- Resolva o problema de hoje com a solução mais simples que funcione e seja testável. Não construa para requisitos hipotéticos.
- Abstraia na terceira repetição, não na primeira. Duplicação é mais barata que a abstração errada.
- Se duas soluções resolvem, escolha a que um recém-chegado entende mais rápido.

## Design patterns

- Pattern é ferramenta, não meta. Use um quando ele resolve um problema **presente**: variação de comportamento (Strategy), integração externa (Adapter), criação complexa (Factory/Builder), acesso a dados isolável (Repository), reação a eventos (Observer) etc.
- Antes de introduzir um pattern, confira em `conventions.md` §3 se o projeto já usa um para o mesmo problema. Reutilize; não crie um segundo jeito de fazer a mesma coisa.
- Pattern novo de alcance estrutural exige ADR e linha em `conventions.md` §3.
- Nunca aplique um pattern só para "deixar mais profissional". Se não sabe dizer o problema que ele resolve, não use.

## Princípios

- **Responsabilidade única:** cada módulo tem um motivo para mudar.
- **Aberto/fechado:** estenda comportamento por adição, não editando o que já funciona, quando a variação é real.
- **Substituição:** implementações de uma mesma abstração são intercambiáveis sem surpresas.
- **Interfaces enxutas:** quem consome não depende do que não usa.
- **Inversão de dependência:** o domínio não depende de infraestrutura; integrações externas ficam atrás de uma interface.
- Composição em vez de herança.
- Prefira dados imutáveis e funções puras; minimize estado mutável compartilhado.

## Fronteiras e acoplamento

- Separe regra de negócio de I/O (banco, rede, arquivos, interface). O domínio deve ser testável sem infraestrutura.
- Respeite a direção de dependências descrita em `docs/architecture/overview.md`. Uma importação que inverta essa direção é um defeito.
- Contratos públicos (`docs/architecture/contracts.md`) mudam de forma deliberada: atualize o documento, sinalize quebras e versione quando aplicável.
- Alta coesão dentro do módulo, baixo acoplamento entre módulos.
