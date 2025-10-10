
-- Análise de Vendas - TechStore // By Jehann Câmara
-- Este arquivo contém consultas para análise de performance comercial.

USE TechStore;

-- 3.1 Faturamento mensal
SELECT 
    YEAR(data_pedido) as ano,
    MONTH(data_pedido) as mes,
    COUNT(*) as total_pedidos,
    SUM(total) as faturamento_total
FROM pedidos
WHERE status != 'Cancelado'
GROUP BY YEAR(data_pedido), MONTH(data_pedido)
ORDER BY ano, mes;

-- 3.2 Ticket médio por cliente
SELECT 
    c.nome as cliente,
    COUNT(p.id) as total_pedidos,
    SUM(p.total) as total_gasto,
    ROUND(SUM(p.total) / COUNT(p.id), 2) as ticket_medio
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id
WHERE p.status != 'Cancelado'
GROUP BY c.nome
HAVING COUNT(p.id) >= 1
ORDER BY ticket_medio DESC;

-- 3.3 Vendas por status do pedido
SELECT 
    status,
    COUNT(*) as total_pedidos,
    SUM(total) as valor_total
FROM pedidos
GROUP BY status
ORDER BY total_pedidos DESC;