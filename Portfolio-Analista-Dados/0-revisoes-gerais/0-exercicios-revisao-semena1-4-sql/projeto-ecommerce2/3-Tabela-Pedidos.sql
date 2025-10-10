
-- Estudos Sql na DIO // By Jehann C�mara
-- Cria��o da tabela Pedidos

USE ecommerce;

DROP TABLE

IF EXISTS dbo.Pedidos
	CREATE TABLE Pedidos (
		IdPedido INT IDENTITY(1, 1) PRIMARY KEY NOT NULL
		,IdCliente INT NOT NULL
		,IdProduto INT NOT NULL
		,Preco FLOAT NOT NULL
		,Quantidade INT NOT NULL
		)
GO

-- Popular Tabela de Pedidos
INSERT INTO Pedidos
VALUES (
	6
	,1
	,49.99
	,5
	)

INSERT INTO Pedidos
VALUES (
	12
	,2
	,74.99
	,12
	)

	INSERT INTO Pedidos
VALUES (
	12
	,3
	,74.99
	,20
	)

INSERT INTO Pedidos
VALUES (
	16
	,4
	,89.99
	,60
	)

SELECT * FROM Pedidos