
-- Estudos Sql na DIO // By Jehann Câmara
-- Funções Built-in em Joins

USE ecommerce;

SELECT sum(preco * Quantidade) AS precoTotal
FROM pedidoItem t1
INNER JOIN StatusPedidoLog t2 ON t1.idPedido = t2.idPedido
	AND t1.idProduto = t2.idProduto
	AND t1.idPedido IS NOT NULL
INNER JOIN StatusPedidoItem t3 ON t3.idStatusPedidoItem = t2.idStatusPedidoItem
	AND t3.idStatusPedidoItem > 0
	AND t2.idStatusPedidoItem IS NOT NULL
WHERE t3.idStatusPedidoItem BETWEEN 0
		AND 4

SELECT avg(preco) AS MediaPreco
FROM pedidoItem t1
INNER JOIN StatusPedidoLog t2 ON t1.idPedido = t2.idPedido
	AND t1.idProduto = t2.idProduto
	AND t1.idPedido IS NOT NULL
INNER JOIN StatusPedidoItem t3 ON t3.idStatusPedidoItem = t2.idStatusPedidoItem
	AND t3.idStatusPedidoItem > 0
	AND t2.idStatusPedidoItem IS NOT NULL
WHERE t3.idStatusPedidoItem BETWEEN 0
		AND 4

SELECT count(*) quantidadeLinhas
FROM pedidoItem t1
INNER JOIN StatusPedidoLog t2 ON t1.idPedido = t2.idPedido
	AND t1.idProduto = t2.idProduto
	AND t1.idPedido IS NOT NULL
INNER JOIN StatusPedidoItem t3 ON t3.idStatusPedidoItem = t2.idStatusPedidoItem
	AND t3.idStatusPedidoItem > 0
	AND t2.idStatusPedidoItem IS NOT NULL
WHERE t3.idStatusPedidoItem BETWEEN 0
		AND 4