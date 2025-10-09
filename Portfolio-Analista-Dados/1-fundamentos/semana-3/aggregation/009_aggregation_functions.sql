-- Script 009: Funções de Agregação
-- Data: 2024-01-16
-- Descrição: Prática com funções agregadoras

USE data_analytics_study;

-- COUNT: Contar total de vendas
SELECT COUNT(*) AS total_vendas FROM sales;

-- SUM: Soma do total vendido
SELECT SUM(total_amount) AS total_arrecadado FROM sales;

-- AVG: Valor médio das vendas
SELECT AVG(total_amount) AS valor_medio_venda FROM sales;

-- MAX/MIN: Maior e menor venda
SELECT 
    MAX(total_amount) AS maior_venda,
    MIN(total_amount) AS menor_venda
FROM sales;

-- Múltiplas agregações
SELECT 
    COUNT(*) AS total_vendas,
    SUM(total_amount) AS total_arrecadado,
    AVG(total_amount) AS media_venda,
    MAX(total_amount) AS maior_venda,
    MIN(total_amount) AS menor_venda
FROM sales;