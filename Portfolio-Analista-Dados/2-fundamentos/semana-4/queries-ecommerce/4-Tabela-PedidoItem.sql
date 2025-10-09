
-- Estudos Sql na DIO // By Jehann C�mara
-- Cria��o da tabela PedidoItem

USE ecommerce;

DROP TABLE

IF EXISTS dbo.PedidoItem
	CREATE TABLE PedidoItem (
		IdPedido INT NOT NULL
		,IdProduto INT NOT NULL
		,Preco FLOAT NOT NULL
		,Quantidade INT NOT NULL
		)