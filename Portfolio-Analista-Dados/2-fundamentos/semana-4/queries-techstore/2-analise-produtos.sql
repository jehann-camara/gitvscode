
-- Análise de Produtos - TechStore // By Jehann Câmara
-- Este arquivo contém consultas para análise de desempenho e estoque de produtos.

USE TechStore;

-- 2.1 Produtos mais vendidos (quantidade)
SELECT 
    p.nome as produto,
    SUM(pi.quantidade) as total_vendido,
    SUM(pi.quantidade * pi.preco_unitario) as faturamento_total
FROM produtos p
INNER JOIN pedidos_itens pi ON p.id = pi.produto_id
INNER JOIN pedidos ped ON pi.pedido_id = ped.id
WHERE ped.status != 'Cancelado'
GROUP BY p.nome
ORDER BY total_vendido DESC;

-- 2.2 Produtos com maior margem de lucro
SELECT 
    nome,
    preco,
    custo,
    (preco - custo) as lucro_unitario,
    ROUND(((preco - custo) / preco) * 100, 2) as margem_percentual,
    estoque
FROM produtos
ORDER BY margem_percentual DESC;

-- 2.3 Categorias com maior faturamento
SELECT 
    cat.nome as categoria,
    SUM(pi.quantidade * pi.preco_unitario) as faturamento_total
FROM categorias cat
INNER JOIN produtos p ON cat.id = p.categoria_id
INNER JOIN pedidos_itens pi ON p.id = pi.produto_id
INNER JOIN pedidos ped ON pi.pedido_id = ped.id
WHERE ped.status != 'Cancelado'
GROUP BY cat.nome
ORDER BY faturamento_total DESC;