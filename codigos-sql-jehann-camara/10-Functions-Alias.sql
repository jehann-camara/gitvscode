
-- Estudos Sql na DIO // By Jehann Câmara
-- Criação da tabela Clientes
USE ecommerce
GO

-- Functions ('CREATE FUNCTION' deve ser a primeira instrução em um lote de consultas.)
CREATE FUNCTION dbo.CalcularDesconto (
	@Preco DECIMAL(13, 2)
	,@PercentualDesconto INT
	)
RETURNS DECIMAL(13, 2)
AS
BEGIN
	-- Retorna o valor da variável
	RETURN @preco - @preco / 100 * @PercentualDesconto;
END;

GO
-- Executar a função criada
SELECT dbo.CalcularDesconto(10, 2);

GO

-- Selects
SELECT *
FROM Clientes -- alt + F1

-- Selects com Alias e Format
SELECT NomeProduto
	,Preco
	,Format(preco - preco / 100 * 10, 'N2') PrecoComDesconto
FROM Produtos
WHERE Tamanho = 'M'

SELECT NomeProduto
	,Preco
	,DBO.CalcularDesconto(preco, 50) AS PrecoComDesconto
FROM Produtos
WHERE Tamanho = 'M'

SELECT *
	,CASE 
		WHEN TipoPessoa = 'J'
			THEN 'Jurídica'
		WHEN TipoPessoa = 'F'
			THEN 'Física'
		ELSE 'Pessoa Indefinida'
		END AS TipoPessoaDescricao
FROM Clientes -- alt + F1