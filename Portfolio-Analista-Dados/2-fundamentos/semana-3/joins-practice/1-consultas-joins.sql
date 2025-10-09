
-- Consultas Joins // By Jehann Câmara

USE TechStore;

-- 1. INNER JOIN BÁSICO
-- Pedidos com informações do cliente
SELECT 
    p.id as pedido_id,
    p.data_pedido,
    c.nome as cliente_nome,
    p.total
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.id;

-- 2. LEFT JOIN
-- Todos os clientes, mesmo sem pedidos
SELECT 
    c.nome as cliente,
    p.data_pedido,
    p.total
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id;

-- 3. MÚLTIPLOS JOINS
-- Detalhes completos do pedido
SELECT 
    c.nome as cliente,
    p.data_pedido,
    pr.nome as produto,
    pi.quantidade,
    pi.preco_unitario
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.id
INNER JOIN pedidos_itens pi ON p.id = pi.pedido_id
INNER JOIN produtos pr ON pi.produto_id = pr.id;

-- 4. SELF JOIN (caso precise)
-- Encontrar clientes da mesma cidade
SELECT 
    c1.nome as cliente1,
    c2.nome as cliente2,
    c1.cidade
FROM clientes c1
INNER JOIN clientes c2 ON c1.cidade = c2.cidade AND c1.id <> c2.id;

-- 5. GROUP BY com JOIN
-- Total gasto por cliente
SELECT 
    c.nome as cliente,
    SUM(p.total) as total_gasto,
    COUNT(p.id) as total_pedidos
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.nome
ORDER BY total_gasto DESC;

-- 6. HAVING com JOIN
-- Clientes que gastaram mais de R$ 1000
SELECT 
    c.nome as cliente,
    SUM(p.total) as total_gasto
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.nome
HAVING SUM(p.total) > 1000
ORDER BY total_gasto DESC;

-- 7. JOIN com WHERE
-- Pedidos de um cliente específico
SELECT 
    p.data_pedido,
    p.total,
    c.nome as cliente
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.id
WHERE c.nome = 'João Silva';

-- 8. MÚLTIPLAS CONDIÇÕES NO JOIN
-- Produtos vendidos com desconto
SELECT 
    pr.nome as produto,
    pi.preco_unitario as preco_venda,
    pr.preco as preco_original,
    (pr.preco - pi.preco_unitario) as desconto
FROM produtos pr
INNER JOIN pedidos_itens pi ON pr.id = pi.produto_id
WHERE pi.preco_unitario < pr.preco;

-- 9. Clientes e seus pedidos
SELECT clientes.nome, pedidos.data_pedido, pedidos.total
FROM clientes
INNER JOIN pedidos ON clientes.id = pedidos.cliente_id;

-- 10. Todos os clientes, mesmo sem pedidos
SELECT clientes.nome, pedidos.data_pedido
FROM clientes
LEFT JOIN pedidos ON clientes.id = pedidos.cliente_id;

-- 11. Total de pedidos por cliente
SELECT cliente_id, COUNT(*) as total_pedidos
FROM pedidos
GROUP BY cliente_id;

-- 12. Média de preço por categoria
SELECT categoria_id, AVG(preco) as preco_medio
FROM produtos
GROUP BY categoria_id;

-- 13. Valor total gasto por cliente
SELECT clientes.nome, SUM(pedidos.total) as total_gasto
FROM clientes
INNER JOIN pedidos ON clientes.id = pedidos.cliente_id
GROUP BY clientes.nome;

