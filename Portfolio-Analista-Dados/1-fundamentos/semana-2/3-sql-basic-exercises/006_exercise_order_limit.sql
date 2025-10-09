-- Script 006: Exercícios ORDER BY e LIMIT
-- Data: 2024-01-11
-- Descrição: Prática de ordenação e limitação

USE data_analytics_study;

-- Exercício 1: Listar produtos do mais caro para o mais barato
SELECT product_name, price
FROM products
ORDER BY price DESC;

-- Exercício 2: Listar 3 produtos com maior estoque
SELECT product_name, stock_quantity
FROM products
ORDER BY stock_quantity DESC
LIMIT 3;

-- Exercício 3: Listar clientes em ordem alfabética por sobrenome
SELECT first_name, last_name, email
FROM customers
ORDER BY last_name ASC, first_name ASC;

-- Exercício 4: Produtos com preço acima de R$ 500, ordenados por categoria e nome
SELECT product_name, category, price
FROM products
WHERE price > 500
ORDER BY category, product_name;