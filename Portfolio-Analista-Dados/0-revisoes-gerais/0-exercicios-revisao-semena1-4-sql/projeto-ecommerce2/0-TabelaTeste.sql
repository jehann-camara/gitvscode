-- Estudos Sql na DIO // By Jehann C�mara
-- transi��o da tabela Clientes

USE ecommerce;

DROP TABLE

IF EXISTS dbo.Teste
	CREATE TABLE Teste (
		descricao VARCHAR(50) NULL
		,complemento CHAR(20) NOT NULL
		,
		)

INSERT Teste
VALUES (
	NULL
	,'testeComplemento'
	)

SELECT *
FROM Teste

SELECT GETDATE();

SELECT *
FROM sys.tables

DROP TABLE Teste