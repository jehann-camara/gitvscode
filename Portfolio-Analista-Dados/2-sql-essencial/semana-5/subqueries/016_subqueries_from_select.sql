-- Script 016: Subqueries nas cláusulas FROM e SELECT
-- Data: 2024-02-06
-- Descrição: Subqueries em outras partes da query

USE data_analytics_study;

-- Subquery na cláusula FROM (como tabela derivada)
SELECT 
    customer_name,
    total_gasto
FROM (
    SELECT 
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        SUM(s.total_amount) AS total_gasto
    FROM customers c
    INNER JOIN sales s ON c.customer_id = s.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
) AS customer_totals
WHERE total_gasto > 500;

-- Subquery na cláusula SELECT (coluna calculada)
SELECT 
    p.product_name,
    p.price,
    (SELECT AVG(price) FROM products) AS preco_medio,
    p.price - (SELECT AVG(price) FROM products) AS diferenca_media
FROM products p;

-- Subquery correlacionada: Produtos com preço acima da média da categoria
SELECT 
    p1.product_name,
    p1.category,
    p1.price,
    (SELECT AVG(p2.price) FROM products p2 WHERE p2.category = p1.category) AS media_categoria
FROM products p1
WHERE p1.price > (SELECT AVG(p2.price) FROM products p2 WHERE p2.category = p1.category);