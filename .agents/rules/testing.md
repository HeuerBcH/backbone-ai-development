---
description: Como e quando escrever testes
always_apply: false
applies_to: ["**/*"]
---

# Testes

- Teste **comportamento observável** (entradas e saídas, efeitos persistidos, respostas), não detalhes internos de implementação.
- Cada critério de aceite de um ticket deve ser coberto por pelo menos um teste.
- Bug corrigido ganha um teste que falhava antes da correção.
- Escreva o teste antes ou junto com a implementação; nunca "depois, se der tempo".
- Testes são independentes entre si e determinísticos: sem depender de ordem, relógio real ou rede externa.
- O nome do teste descreve o cenário e o resultado esperado: `deve_rejeitar_pedido_sem_itens`.
- Não altere um teste para fazê-lo passar sem entender por que ele falhava. Se o teste estava errado, explique na resposta e na descrição de PR proposta.
- A "seam" de teste (o ponto onde os testes se conectam ao sistema) é definida em cada spec. Não crie seams extras sem motivo.
