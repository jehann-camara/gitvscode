
# 🎯 Projeto SQL Completo - Semana 4

## 🎯 Objetivos do Projeto
- [ ] Aplicar todos os conceitos SQL aprendidos
- [ ] Desenvolver análise completa de negócio
- [ ] Documentar processo e insights
- [ ] Versionar projeto no GitHub

## 📊 Cenário do Projeto: E-commerce "TechStore"

### Descrição do Negócio
A TechStore é uma loja virtual de eletrônicos que precisa de uma análise completa das vendas dos últimos 6 meses.

### Base de Dados
```sql
-- Estrutura completa:
-- clientes (id, nome, email, cidade, data_cadastro)
-- produtos (id, nome, categoria_id, preco, custo, estoque)
-- categorias (id, nome)
-- pedidos (id, cliente_id, data_pedido, status, total)
-- pedidos_itens (id, pedido_id, produto_id, quantidade, preco_unitario)