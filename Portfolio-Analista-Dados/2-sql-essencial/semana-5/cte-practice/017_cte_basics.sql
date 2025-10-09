-- Script 017: CTEs Básicas (Common Table Expressions)
-- Data: 2024-02-07
-- Descrição: Introdução a CTEs com WITH

USE data_analytics_study;

-- CTE simples: Total de vendas por cliente
WITH vendas_por_cliente AS (
    SELECT 
        customer_id,
        COUNT(*) AS total_vendas,
        SUM(total_amount) AS total_gasto
    FROM sales
    GROUP BY customer_id
)
SELECT 
    c.first_name,
    c.last_name,
    vpc.total_vendas,
    vpc.total_gasto
FROM vendas_por_cliente vpc
INNER JOIN customers c ON vpc.customer_id = c.customer_id
ORDER BY vpc.total_gasto DESC;

-- Múltiplas CTEs: Análise de performance por categoria
WITH vendas_categoria AS (
    SELECT 
        p.category,
        COUNT(s.sale_id) AS total_vendas,
        SUM(s.total_amount) AS receita_total
    FROM sales s
    INNER JOIN products p ON s.product_id = p.product_id
    GROUP BY p.category
),
media_categoria AS (
    SELECT AVG(receita_total) AS media_receita
    FROM vendas_categoria
)
SELECT 
    vc.category,
    vc.total_vendas,
    vc.receita_total,
    mc.media_receita,
    vc.receita_total - mc.media_receita AS diferenca_media
FROM vendas_categoria vc
CROSS JOIN media_categoria mc
ORDER BY vc.receita_total DESC;