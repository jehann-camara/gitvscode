-- Script 011: Filtros com HAVING
-- Data: 2024-01-18
-- Descrição: Filtragem em grupos com HAVING

USE data_analytics_study;

-- Clientes com mais de 1 venda
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(s.sale_id) AS total_vendas
FROM customers c
INNER JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(s.sale_id) > 1;

-- Categorias com vendas superiores a R$ 500
SELECT 
    p.category,
    SUM(s.total_amount) AS total_vendido
FROM products p
INNER JOIN sales s ON p.product_id = s.product_id
GROUP BY p.category
HAVING SUM(s.total_amount) > 500;

-- Média de venda por cliente, filtrando médias altas
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    AVG(s.total_amount) AS media_venda
FROM customers c
INNER JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING AVG(s.total_amount) > 300;