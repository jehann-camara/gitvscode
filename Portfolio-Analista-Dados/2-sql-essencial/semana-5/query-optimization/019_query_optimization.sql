-- Script 019: Otimização de Consultas
-- Data: 2024-02-09
-- Descrição: Índices, EXPLAIN e boas práticas

USE data_analytics_study;

-- Criar índices para melhorar performance
CREATE INDEX idx_sales_customer_date ON sales(customer_id, sale_date);
CREATE INDEX idx_sales_amount ON sales(total_amount);
CREATE INDEX idx_products_category_price ON products(category, price);
CREATE INDEX idx_customers_name ON customers(first_name, last_name);

-- Analisar plano de execução (EXPLAIN)
EXPLAIN SELECT 
    c.first_name,
    c.last_name,
    SUM(s.total_amount) AS total_gasto
FROM customers c
INNER JOIN sales s ON c.customer_id = s.customer_id
WHERE s.sale_date BETWEEN '2024-01-01' AND '2024-01-31'
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING total_gasto > 1000;

-- Query otimizada usando índices
SELECT 
    c.first_name,
    c.last_name,
    SUM(s.total_amount) AS total_gasto
FROM customers c
INNER JOIN sales s ON c.customer_id = s.customer_id
WHERE s.sale_date >= '2024-01-01' AND s.sale_date <= '2024-01-31'
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(s.total_amount) > 1000;

-- Análise de performance com informações detalhadas
EXPLAIN FORMAT=JSON
SELECT p.product_name, COUNT(s.sale_id) as total_vendas
FROM products p
LEFT JOIN sales s ON p.product_id = s.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_vendas DESC;

-- Remover índices (se necessário para testes)
-- DROP INDEX idx_sales_customer_date ON sales;
-- DROP INDEX idx_sales_amount ON sales;
-- DROP INDEX idx_products_category_price ON products;
-- DROP INDEX idx_customers_name ON customers;