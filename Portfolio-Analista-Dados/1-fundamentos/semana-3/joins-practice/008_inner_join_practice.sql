-- Script 008: Prática de INNER JOIN
-- Data: 2024-01-15
-- Descrição: Exercícios com INNER JOIN

USE data_analytics_study;

-- JOIN básico: Vendas com informações do cliente
SELECT 
    s.sale_id,
    c.first_name,
    c.last_name,
    s.sale_date,
    s.total_amount
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id;

-- JOIN múltiplo: Vendas com cliente e produto
SELECT 
    s.sale_id,
    c.first_name,
    c.last_name,
    p.product_name,
    s.quantity,
    s.unit_price,
    s.total_amount
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
INNER JOIN products p ON s.product_id = p.product_id;

-- JOIN com WHERE: Vendas de um cliente específico
SELECT 
    s.sale_date,
    p.product_name,
    s.quantity,
    s.total_amount
FROM sales s
INNER JOIN products p ON s.product_id = p.product_id
WHERE s.customer_id = 1;