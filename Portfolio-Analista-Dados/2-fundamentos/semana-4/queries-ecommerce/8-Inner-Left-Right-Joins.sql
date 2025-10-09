
-- Estudos Sql na DIO // By Jehann Câmara
-- Inner Joins, Left Joins, Right Joins

USE ecommerce;

SELECT *
FROM Clientes cli -- alt + F1

SELECT *
FROM Pedidos ped -- alt + F1

-- Retorna somente os registros de ambas as tabelas que existem nas duas tabelas
SELECT *
FROM Clientes cli
INNER JOIN Pedidos ped ON cli.IdCliente = ped.IdCliente

-- Retorna todos os registros da tabela a esquerda, mesmo que N�O tenham correspond�ncia na tabela � direita.
SELECT *
FROM Clientes cli
LEFT JOIN Pedidos ped ON cli.IdCliente = ped.IdCliente

-- Retorna todos os registros da tabela a direita, mesmo que N�O tenham correspond�ncia na tabela � esquerda.
SELECT *
FROM Clientes cli
RIGHT JOIN Pedidos ped ON cli.IdCliente = ped.IdCliente

-- Selects Condicionais e Joins
SELECT *
FROM Clientes cli
LEFT JOIN Pedidos ped ON cli.IdCliente = ped.IdCliente
WHERE cli.IdCliente > 7

SELECT cli.nomeCliente
	,ped.Quantidade
	,CASE 
		WHEN cli.tipoPessoa = 'F'
			THEN 'F�sica'
		WHEN cli.tipoPessoa = 'J'
			THEN 'Jur�dica'
		END TipoPessoa
FROM Clientes cli
LEFT JOIN pedidos ped ON cli.idCliente = ped.idCliente
WHERE cli.idCliente > 3

SELECT *
FROM pedidoItem pedItem
INNER JOIN StatusPedidoLog stsPedLog ON pedItem.IdPedido = stsPedLog.idPedido
	AND pedItem.IdProduto = stsPedLog.idProduto
	AND pedItem.IdPedido IS NOT NULL
INNER JOIN StatusPedidoItem stsPedItem ON stsPedItem.IdStatusPedidoItem = stsPedLog.IdStatusPedidoItem
	AND stsPedItem.IdStatusPedidoItem > 0
	AND stsPedLog.IdStatusPedidoItem IS NOT NULL
WHERE stsPedItem.IdStatusPedidoItem BETWEEN 0
		AND 3

--Principais Selects
SELECT *
FROM Pedidos

SELECT *
FROM StatusPedidoItem

SELECT *
FROM StatusPedidoLog