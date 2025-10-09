-- Script 005: Exercícios com WHERE
-- Data: 2024-01-10
-- Descrição: Prática de filtros com WHERE

USE data_analytics_study;

-- Exercício 1: Selecionar produtos da categoria 'Acessórios'
SELECT product_name, price
FROM products
WHERE category = 'Acessórios';

-- Exercício 2: Selecionar produtos com preço maior que R$ 100,00
SELECT product_name, category, price
FROM products
WHERE price > 100.00;

-- Exercício 3: Selecionar produtos com estoque entre 10 e 20 unidades
SELECT product_name, stock_quantity
FROM products
WHERE stock_quantity BETWEEN 10 AND 20;

-- Exercício 4: Selecionar produtos que contenham 'Mouse' no nome
SELECT product_name, price
FROM products
WHERE product_name LIKE '%Mouse%';