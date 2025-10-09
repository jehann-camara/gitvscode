
-- Insights Estrat�gicos - TechStore  // By Jehann C�mara
-- Este arquivo cont�m consultas avan�adas para tomada de decis�o.

USE TechStore;

-- 4.1 Clientes VIP (top 10% em gastos)
WITH clientes_vip AS (
    SELECT 
        cliente_id,
        SUM(total) as total_gasto,
        NTILE(10) OVER (ORDER BY SUM(total) DESC) as decil
    FROM pedidos
    WHERE status != 'Cancelado'
    GROUP BY cliente_id
)
SELECT 
    c.nome,
    cv.total_gasto
FROM clientes_vip cv
INNER JOIN clientes c ON cv.cliente_id = c.id
WHERE cv.decil = 1
ORDER BY cv.total_gasto DESC;

-- 4.2 Evolu��o de vendas com crescimento mensal
WITH vendas_mensais AS (
    SELECT 
        YEAR(data_pedido) as ano,
        MONTH(data_pedido) as mes,
        SUM(total) as faturamento
    FROM pedidos
    WHERE status != 'Cancelado'
    GROUP BY YEAR(data_pedido), MONTH(data_pedido)
),
crescimento AS (
    SELECT 
        ano,
        mes,
        faturamento,
        LAG(faturamento) OVER (ORDER BY ano, mes) as faturamento_mes_anterior,
        CASE 
            WHEN LAG(faturamento) OVER (ORDER BY ano, mes) IS NULL THEN NULL
            ELSE ROUND(((faturamento - LAG(faturamento) OVER (ORDER BY ano, mes)) / LAG(faturamento) OVER (ORDER BY ano, mes)) * 100, 2)
        END as percentual_crescimento
    FROM vendas_mensais
)
SELECT 
    ano,
    mes,
    faturamento,
    faturamento_mes_anterior,
    percentual_crescimento
FROM crescimento
ORDER BY ano, mes;

-- 4.3 Produtos com baixo desempenho (estoque alto, vendas baixas)
SELECT 
    p.nome as produto,
    p.estoque,
    COALESCE(SUM(pi.quantidade), 0) as total_vendido,
    ROUND(COALESCE(SUM(pi.quantidade), 0) * 1.0 / NULLIF(p.estoque, 0), 2) as giro_estoque
FROM produtos p
LEFT JOIN pedidos_itens pi ON p.id = pi.produto_id
LEFT JOIN pedidos ped ON pi.pedido_id = ped.id AND ped.status != 'Cancelado'
GROUP BY p.id, p.nome, p.estoque
HAVING COALESCE(SUM(pi.quantidade), 0) = 0 OR ROUND(COALESCE(SUM(pi.quantidade), 0) * 1.0 / NULLIF(p.estoque, 0), 2) < 0.5
ORDER BY giro_estoque;