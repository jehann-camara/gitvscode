-- Script 014: Análise de Clientes
-- Data: 2024-01-24
-- Descrição: Comportamento e segmentação de clientes

USE data_analytics_study;

-- Segmentação por valor gasto
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(s.sale_id) AS total_compras,
    SUM(s.total_amount) AS total_gasto,
    CASE 
        WHEN SUM(s.total_amount) > 1000 THEN 'Cliente Premium'
        WHEN SUM(s.total_amount) > 500 THEN 'Cliente Valor'
        ELSE 'Cliente Regular'
    END AS segmento
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_gasto DESC;

-- Frequência de compras por cliente
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(s.sale_id) AS frequencia_compras,
    DATEDIFF(MAX(s.sale_date), MIN(s.sale_date)) AS periodo_ativacao,
    CASE 
        WHEN COUNT(s.sale_id) > 1 THEN 'Comprador Recorrente'
        ELSE 'Comprador Único'
    END AS tipo_comprador
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- Clientes inativos (sem compras nos últimos 30 dias)
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    MAX(s.sale_date) AS ultima_compra,
    DATEDIFF(CURRENT_DATE, MAX(s.sale_date)) AS dias_sem_comprar
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email
HAVING MAX(s.sale_date) IS NULL OR DATEDIFF(CURRENT_DATE, MAX(s.sale_date)) > 30;