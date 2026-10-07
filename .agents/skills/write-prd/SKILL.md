---
name: write-prd
description: Conduz uma entrevista e escreve ou revisa o PRD (documento de requisitos do produto) em docs/product/prd.md. Use quando o usuário quiser definir um produto ou funcionalidade nova, levantar requisitos, ou quando o PRD estiver desatualizado em relação às decisões.
---

# Escrever PRD

O PRD define **o que** o produto faz e **por quê**, nunca **como** será implementado.

## Passos

1. Leia `docs/product/prd.md`, `docs/product/decisions-log.md`, `docs/decisions/README.md` e `docs/glossary.md` para saber o que já existe.
2. Entreviste o usuário **uma pergunta por vez**, cobrindo: problema, público, propostas de valor, fluxos principais, regras de negócio, fora de escopo, requisitos não funcionais, métricas de sucesso. Para cada pergunta, ofereça uma recomendação.
3. Ao final de cada rodada, registre as respostas com data em `docs/product/decisions-log.md`.
4. Escreva ou atualize `docs/product/prd.md` seguindo a estrutura do arquivo. Numere requisitos funcionais (`RF-01`) e não funcionais (`RNF-01`).
5. Derive as user stories em `docs/product/user-stories.md` (`US-01`...), cada uma com critérios de aceite testáveis e os RFs que cobre.
6. Esboce as entidades e regras do domínio que surgirem em `docs/architecture/domain-model.md`.
7. Liste ao usuário as lacunas que ainda restam. Não as preencha por conta própria.

## Boas práticas

- Pergunte pelo problema antes da solução. "Quero um botão" esconde uma necessidade.
- Requisito bom é verificável: dá para escrever um teste ou demonstração.
- "Fora de escopo" é tão importante quanto o escopo: evita que o agente construa demais.
- Nenhuma decisão de implementação (tecnologia, tabela, endpoint) entra no PRD.

## Fechamento

- **Registre:** `decisions-log.md` (rodada datada), `prd.md`, `user-stories.md`.
- **Atualize:** `glossary.md` com termos novos; `domain-model.md` com entidades; ADR (skill `record-decision`) para decisões com impacto técnico; "Questões em aberto" do PRD com o que faltou.
- **Verifique:** todo RF verificável; toda US referencia RFs; "Fora de escopo" preenchido.
- **Responda:** resumo do que foi definido, lacunas abertas e próximo passo sugerido (normalmente `write-spec`).
