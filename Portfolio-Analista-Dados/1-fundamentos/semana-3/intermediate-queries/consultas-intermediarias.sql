
-- Agrupar e calcular totais // By Jehann Câmara

USE TechStore;

-- 1. Produtos mais vendidos (quantidade)
SELECT p.nome, SUM(pi.quantidade) as total_vendido
FROM produtos p
INNER JOIN pedidos_itens pi ON p.id = pi.produto_id
GROUP BY p.nome
ORDER BY total_vendido DESC;

-- 2. Clientes que mais gastaram
SELECT c.nome, SUM(p.total) as total_gasto
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.nome
ORDER BY total_gasto DESC;

-- 3. Vendas por categoria
SELECT cat.nome as categoria, SUM(pi.quantidade * pi.preco_unitario) as total_vendas
FROM categorias cat
INNER JOIN produtos p ON cat.id = p.categoria_id
INNER JOIN pedidos_itens pi ON p.id = pi.produto_id
GROUP BY cat.nome; 

-- 4. Usar AS para apelidar colunas e tabelas
SELECT 
    cli.nome as cliente_nome,
    ped.data_pedido as data,
    ped.total as valor_total
FROM clientes as cli
INNER JOIN pedidos as ped ON cli.id = ped.cliente_id;

-- 5. Clientes com mais de 3 pedidos
SELECT cliente_id, COUNT(*) as total_pedidos
FROM pedidos
GROUP BY cliente_id
HAVING COUNT(*) > 3;

-- 6. Encontrar o mês com maior volume de vendas
SELECT 
    YEAR(data_pedido) as ano,
    MONTH(data_pedido) as mes, 
    SUM(total) as total_vendas
FROM pedidos
GROUP BY YEAR(data_pedido), MONTH(data_pedido)
ORDER BY total_vendas DESC;

-- 7. Clientes que não fizeram pedidos nos últimos 30 dias
SELECT nome, email
FROM clientes
WHERE id NOT IN (
    SELECT DISTINCT cliente_id 
    FROM pedidos 
    WHERE data_pedido >= DATEADD(day, -30, GETDATE())
);