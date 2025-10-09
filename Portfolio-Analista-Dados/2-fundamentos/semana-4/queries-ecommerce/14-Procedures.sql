
-- Estudos Sql na DIO // By Jehann Câmara
-- Criação de Procedures

USE novoEcommerce;

-- Criação de Procedure
CREATE PROCEDURE InserirNovoProduto (
	@Nome VARCHAR(255)
	,@Cor VARCHAR(50)
	,@Preco DECIMAL
	,@Tamanho VARCHAR(5)
	,@Genero CHAR(1)
	)
AS
INSERT INTO Produtos (
	Nome
	,Cor
	,Preco
	,Tamanho
	,Genero
	)
VALUES (
	@Nome
	,@Cor
	,@Preco
	,@Tamanho
	,@Genero
	)
GO

--testando procedures com parenteses
CREATE PROCEDURE InserirNovoProduto2 (
	@Nome VARCHAR(255)
	,@Cor VARCHAR(50)
	,@Preco DECIMAL
	,@Tamanho VARCHAR(5)
	,@Genero CHAR(1)
	)
AS
GO

INSERT INTO Produtos (
	Nome
	,Cor
	,Preco
	,Tamanho
	,Genero
	)
VALUES (
	@Nome
	,@Cor
	,@Preco
	,@Tamanho
	,@Genero
	)

-- drop procedure
DROP PROCEDURE InserirNovoProduto2

-- executar a  procedure ( execute ou exec)
EXECUTE InserirNovoProduto2 'Novo produto procedure2'
	,'Azul'
	,60
	,'GG'
	,'M'

-- Selects
SELECT *
FROM Produtos