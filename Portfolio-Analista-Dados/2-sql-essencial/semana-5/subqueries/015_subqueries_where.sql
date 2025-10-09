-- Script 015: Subqueries na cláusula WHERE
-- Data: 2024-02-05
-- Descrição: Utilizar subqueries para filtrar resultados

USE data_analytics_study;

-- Exemplo 1: Produtos com preço acima da média
SELECT product_name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- Exemplo 2: Clientes que realizaram compras acima da média
SELECT first_name, last_name, email
FROM customers
WHERE customer_id IN (
    SELECT DISTINCT customer_id 
    FROM sales 
    WHERE total_amount > (SELECT AVG(total_amount) FROM sales)
);

-- Exemplo 3: Produtos que nunca foram vendidos
SELECT product_name, category
FROM products
WHERE product_id NOT IN (SELECT DISTINCT product_id FROM sales);

-- Exemplo 4: Clientes com total gasto superior a R$ 1000
SELECT first_name, last_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM sales
    GROUP BY customer_id
    HAVING SUM(total_amount) > 1000
);