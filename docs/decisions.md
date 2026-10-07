# Decisões

Registro de toda escolha entre alternativas reais — de produto ou técnica. Responde, meses depois, "por que está assim?".

- **Só acrescente.** Mudou de ideia? Nova entrada que substitui a anterior; a antiga recebe "substituída por D-NNN".
- **Quando registrar:** tecnologia, dependência estrutural, padrão de arquitetura, formato de dados, regra de negócio com impacto técnico, ou qualquer coisa que um recém-chegado tentaria "consertar".
- **Status:** proposta → aceita (só com confirmação do humano) | rejeitada | substituída.
- Quando este arquivo ficar grande, mova entradas antigas para `docs/decisions/` (um arquivo por decisão) e mantenha aqui o índice.

## Modelo

```markdown
## D-NNN — Título no imperativo
**Data:** AAAA-MM-DD · **Tipo:** produto | técnica · **Status:** proposta

**Contexto:** o problema e as restrições.
**Alternativas:** A) ... (prós/contras) · B) ... (prós/contras)
**Decisão:** o que foi escolhido e o principal motivo.
**Consequências:** o que melhora, o que custa, o que precisa mudar.
```

---

## D-001 — Adotar documentação e governança orientadas a agentes de IA
**Data:** {{AAAA-MM-DD}} · **Tipo:** técnica · **Status:** aceita

**Contexto:** o projeto será desenvolvido com apoio intenso de agentes de IA, que não guardam memória entre sessões, supõem quando falta contexto e variam o padrão se ele não estiver escrito.
**Alternativas:** A) documentação livre, conforme a necessidade (sem custo inicial; cada sessão recomeça do zero e decisões se perdem) · B) estrutura fixa versionada no repositório (contexto reproduzível e auditável; exige manter os documentos verdadeiros).
**Decisão:** B — `AGENTS.md` como entrada, `.agents/` para regras, skills, subagentes e hooks, `docs/` para produto, arquitetura, decisões e estado. Pedidos são tratados por nível (Rápido, Padrão, Grande) para que a rotina não pague o custo do trabalho grande.
**Consequências:** onboarding imediato de pessoas e agentes; rastreabilidade de requisito a código. Custo: manter os documentos atualizados faz parte de "pronto" nos níveis Padrão e Grande.
