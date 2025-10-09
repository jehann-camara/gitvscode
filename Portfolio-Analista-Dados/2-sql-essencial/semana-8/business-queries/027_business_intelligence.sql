-- Script 027: Consultas de Business Intelligence
-- Data: 2024-02-26
-- Descrição: Consultas analíticas para tomada de decisão

USE ecommerce_normalized;

-- 1. ANÁLISE RFM (Recência, Frequência, Valor) DE CLIENTES
WITH customer_rfm AS (
    SELECT 
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        -- Recência: Dias desde última compra
        DATEDIFF(CURRENT_DATE, MAX(o.order_date)) AS recency,
        -- Frequência: Total de pedidos
        COUNT(o.order_id) AS frequency,
        -- Valor: Total gasto
        COALESCE(SUM(o.total_amount), 0) AS monetary_value
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.status_id IN (2,3,4) -- Apenas pedidos confirmados, enviados ou entregues
    GROUP BY c.customer_id, c.first_name, c.last_name
),
rfm_scores AS (
    SELECT 
        customer_id,
        customer_name,
        recency,
        frequency,
        monetary_value,
        -- Score RFM (1-5, onde 5 é melhor)
        NTILE(5) OVER (ORDER BY recency DESC) AS r_score, -- Recência inversa
        NTILE(5) OVER (ORDER BY frequency) AS f_score,
        NTILE(5) OVER (ORDER BY monetary_value) AS m_score
    FROM customer_rfm
)
SELECT 
    customer_id,
    customer_name,
    recency,
    frequency,
    monetary_value,
    r_score,
    f_score,
    m_score,
    (r_score + f_score + m_score) AS rfm_total,
    CASE 
        WHEN (r_score + f_score + m_score) >= 13 THEN 'Cliente Premium'
        WHEN (r_score + f_score + m_score) >= 10 THEN 'Cliente Valor'
        WHEN (r_score + f_score + m_score) >= 7 THEN 'Cliente Médio'
        ELSE 'Cliente Ocasional'
    END AS segmento_cliente
FROM rfm_scores
ORDER BY rfm_total DESC;

-- 2. ANÁLISE DE SAZONALIDADE E TENDÊNCIAS
SELECT 
    YEAR(order_date) AS ano,
    MONTH(order_date) AS mes,
    COUNT(DISTINCT order_id) AS total_pedidos,
    COUNT(DISTINCT customer_id) AS clientes_unicos,
    SUM(total_amount) AS receita_total,
    AVG(total_amount) AS ticket_medio,
    SUM(total_amount) / COUNT(DISTINCT customer_id) AS receita_por_cliente
FROM orders
WHERE order_date >= '2024-01-01' AND status_id IN (2,3,4)
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY ano, mes;

-- 3. ANÁLISE ABC DE PRODUTOS (CURVA 80-20)
WITH product_sales AS (
    SELECT 
        p.product_id,
        p.product_name,
        p.category_id,
        c.category_name,
        SUM(oi.quantity) AS total_vendido,
        SUM(oi.total_price) AS receita_gerada,
        SUM(oi.total_price) / SUM(SUM(oi.total_price)) OVER() AS percentual_receita
    FROM products p
    INNER JOIN categories c ON p.category_id = c.category_id
    INNER JOIN order_items oi ON p.product_id = oi.product_id
    INNER JOIN orders o ON oi.order_id = o.order_id
    WHERE o.status_id IN (2,3,4)
    GROUP BY p.product_id, p.product_name, p.category_id, c.category_name
),
abc_analysis AS (
    SELECT 
        product_id,
        product_name,
        category_name,
        total_vendido,
        receita_gerada,
        percentual_receita,
        SUM(percentual_receita) OVER (ORDER BY receita_gerada DESC) AS cumulative_percentage
    FROM product_sales
)
SELECT 
    product_id,
    product_name,
    category_name,
    total_vendido,
    receita_gerada,
    ROUND(percentual_receita * 100, 2) AS percentual_receita,
    ROUND(cumulative_percentage * 100, 2) AS percentual_acumulado,
    CASE 
        WHEN cumulative_percentage <= 0.8 THEN 'A - Alto Impacto'
        WHEN cumulative_percentage <= 0.95 THEN 'B - Médio Impacto'
        ELSE 'C - Baixo Impacto'
    END AS classificação_abc
FROM abc_analysis
ORDER BY receita_gerada DESC;

-- 4. ANÁLISE DE CARTEIRA DE PEDIDOS
SELECT 
    os.status_name,
    COUNT(o.order_id) AS total_pedidos,
    SUM(o.total_amount) AS valor_total,
    AVG(o.total_amount) AS valor_medio,
    MIN(o.order_date) AS data_mais_antiga,
    MAX(o.order_date) AS data_mais_recente
FROM orders o
INNER JOIN order_status os ON o.status_id = os.status_id
GROUP BY os.status_id, os.status_name
ORDER BY total_pedidos DESC;

-- 5. PREVISÃO DE ESTOQUE E DEMANDA
SELECT 
    p.product_id,
    p.product_name,
    c.category_name,
    i.quantity AS estoque_atual,
    i.reorder_level AS estoque_minimo,
    COALESCE(SUM(oi.quantity), 0) AS demanda_30dias,
    COALESCE(AVG(oi.quantity), 0) AS demanda_media_diaria,
    CASE 
        WHEN i.quantity = 0 THEN 'ESGOTADO'
        WHEN i.quantity <= i.reorder_level THEN 'REABASTECER URGENTE'
        WHEN i.quantity <= (i.reorder_level * 2) THEN 'MONITORAR'
        ELSE 'ESTOQUE OK'
    END AS status_estoque,
    CASE 
        WHEN i.quantity = 0 THEN i.reorder_level * 2
        WHEN i.quantity <= i.reorder_level THEN (i.reorder_level * 3) - i.quantity
        ELSE 0
    END AS sugestao_compra
FROM products p
INNER JOIN categories c ON p.category_id = c.category_id
INNER JOIN inventory i ON p.product_id = i.product_id
LEFT JOIN order_items oi ON p.product_id = oi.product_id
LEFT JOIN orders o ON oi.order_id = o.order_id AND o.order_date >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)
GROUP BY p.product_id, p.product_name, c.category_name, i.quantity, i.reorder_level
ORDER BY status_estoque, estoque_atual ASC;