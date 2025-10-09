
-- Estudos Sql na DIO // By Jehann Câmara
-- Agregações

USE ecommerce;

SELECT prod.IdProduto
	,prod.NomeProduto
	,sum(t1.preco * t1.quantidade) AS somatoria
FROM pedidoItem t1
INNER JOIN StatusPedidoLog t2 ON t1.idPedido = t2.idPedido
	AND t1.IdProduto = t2.IdProduto
	AND t1.idPedido IS NOT NULL
INNER JOIN StatusPedidoItem t3 ON t3.idStatusPedidoItem = t2.idStatusPedidoItem
	AND t3.idStatusPedidoItem > 0
	AND t2.idStatusPedidoItem IS NOT NULL
INNER JOIN Produtos prod ON t1.IdProduto = prod.IdProduto
WHERE t1.idPedido > 0
GROUP BY prod.idProduto
	,prod.descricaoProduto
HAVING sum(t1.preco * t1.quantidade) > 10
ORDER BY prod.idProduto DESC
	-- Where: filtra linhas (registros) ANTES de qualquer agrupamento. (Where = "Onde").
	-- Group by: AGRUPA linhas (registros), com valores iguais , em colunas especificadas. (Group by = "agrupar por")
	-- Having: filtra agrega��es/agrupamentos criadas pelo Group by, funciona com dados agregados. (having = "que tenham")
	-- order by: Ordena o resultado FINAL, POR UMA OU DUAS COLUNAS. (Order by = "ordenar por"))