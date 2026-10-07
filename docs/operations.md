# Operação

Como implantar, reverter e reagir a problemas em produção. Passos curtos e comandos exatos, para seguir sob pressão. **Toda ação em produção exige confirmação humana.** Preencha antes do primeiro deploy.

## Ambientes

| Ambiente | Endereço | Como implantar |
| --- | --- | --- |
| | | |

## Implantar

1. Pré-condições: {{testes verdes, CHANGELOG atualizado, aprovação}}
2. {{procedimento}}
3. Verificar: {{o que checar}}

## Reverter

1. {{procedimento}}
2. Se a versão alterou dados ou esquema: {{o que fazer}}

## Saúde

| Sinal | Onde ver | Alerta quando |
| --- | --- | --- |
| | | |

## Backups

**O quê, quando, onde:** {{}} · **Como restaurar:** {{}} · **Último teste de restauração:** {{AAAA-MM-DD}}

## Incidentes

Um registro por incidente, sem culpados: o objetivo é corrigir falhas de sistema e de processo.

```markdown
### AAAA-MM-DD — Título
**Impacto:** quem foi afetado, o quê, por quanto tempo
**Linha do tempo:** HH:MM sintoma → HH:MM detecção → HH:MM ação → HH:MM estável
**Causa raiz:**
**Ações corretivas:** ação — dono — prazo
```
