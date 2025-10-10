
-- Estudos Sql na DIO // By Jehann C�mara
-- Inserts Produtos e Pedidos

USE ecommerce;

-- Inserts Produtos
INSERT INTO Produtos
VALUES (
	'Mountain Bike Socks, L'
	,'Branco'
	,'9.50'
	,'G'
	,'U'
	)

INSERT INTO Produtos
VALUES (
	'AWC Logo Cap'
	,'Colorido'
	,'8.99'
	,''
	,'U'
	)

INSERT INTO Produtos
VALUES (
	'Long-Sleeve Logo Jersey, S'
	,'Colorido'
	,'49.99'
	,'P'
	,'U'
	)

-- Inserts Pedidos
-- Um valor expl�cito para a coluna de identidade na tabela 'Pedidos' 
-- s� pode ser especificado quando uma lista de colunas � usada e o valor de IDENTITY_INSERT � ON.
-- Inserts ap�s set de identity
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

-- Insert PedidoItem
INSERT PedidoItem
VALUES (
	1
	,1
	,1.5
	,2
	)

-- Selects
SELECT *
FROM Pedidos -- alt + f1

SELECT *
FROM PedidoItem -- alt + f1

SELECT *
FROM PedidoItem -- alt + f1

SELECT *
FROM Clientes

SELECT *
FROM produtos