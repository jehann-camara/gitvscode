-- Script 010: Prática com GROUP BY
-- Data: 2024-01-17
-- Descrição: Agrupamento de dados

USE data_analytics_study;

-- Total de vendas por cliente
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(s.sale_id) AS total_vendas,
    SUM(s.total_amount) AS total_gasto
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- Vendas por categoria de produto
SELECT 
    p.category,
    COUNT(s.sale_id) AS quantidade_vendas,
    SUM(s.total_amount) AS total_vendido,
    AVG(s.total_amount) AS media_venda
FROM products p
LEFT JOIN sales s ON p.product_id = s.product_id
GROUP BY p.category;

-- Vendas por mês
SELECT 
    YEAR(sale_date) AS ano,
    MONTH(sale_date) AS mes,
    COUNT(*) AS total_vendas,
    SUM(total_amount) AS total_arrecadado
FROM sales
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY ano, mes;