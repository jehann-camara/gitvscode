
-- Estudos Sql na DIO // By Jehann C�mara
-- Cria��o da tabela Clientes

USE ecommerce;

SELECT *
FROM Clientes -- alt + f1

INSERT INTO Clientes
VALUES (
	'Jehann'
	,'C�mara'
	,'j.camara.it@outlook.com'
	,1
	,'Jan  7 2025 12:00AM'
	)

-- Select com Where
SELECT *
FROM Clientes
WHERE AceitaComunicados = 1

SELECT *
FROM Clientes
WHERE AceitaComunicados = 0

-- Update com Where
UPDATE Clientes
SET NomeCliente = 'Novo Terri'
WHERE AceitaComunicados = 1

-- Delete com Where
DELETE
FROM Clientes
WHERE idCliente IN (
		5
		,4
		,3
		,2
		)

SELECT *
FROM Clientes
WHERE idCliente >= 1
	OR AceitaComunicados = 0
	--delete  from Clientes