-- Script 013: Análise de Vendas
-- Data: 2024-01-23
-- Descrição: Queries analíticas sobre vendas

USE data_analytics_study;

-- Análise de performance de vendas
SELECT 
    p.category,
    COUNT(s.sale_id) AS total_vendas,
    SUM(s.total_amount) AS receita_total,
    AVG(s.total_amount) AS ticket_medio,
    SUM(s.quantity) AS total_itens_vendidos
FROM sales s
INNER JOIN products p ON s.product_id = p.product_id
GROUP BY p.category
ORDER BY receita_total DESC;

-- Evolução de vendas ao longo do tempo
SELECT 
    DATE(sale_date) AS data_venda,
    COUNT(*) AS vendas_dia,
    SUM(total_amount) AS receita_dia,
    AVG(total_amount) AS ticket_medio_dia
FROM sales
GROUP BY DATE(sale_date)
ORDER BY data_venda;

-- Top 5 produtos mais vendidos
SELECT 
    p.product_name,
    p.category,
    SUM(s.quantity) AS total_vendido,
    SUM(s.total_amount) AS receita_gerada
FROM sales s
INNER JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_vendido DESC
LIMIT 5;