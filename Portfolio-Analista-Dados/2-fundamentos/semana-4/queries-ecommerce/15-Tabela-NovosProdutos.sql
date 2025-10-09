
-- Estudos Sql na DIO // By Jehann Câmara
-- Criação da tabela Clientes

USE novoEcommerce;

DROP TABLE

IF EXISTS dbo.NovosProdutos
	-- Ctrl + K + C = sele��o para comentario
	CREATE TABLE NovosProdutos (
		Id INT IDENTITY(1, 1) PRIMARY KEY NOT NULL
		,Nome VARCHAR(255) NOT NULL
		,Cor VARCHAR(50) NULL
		,Preco DECIMAL(13, 2) NOT NULL
		,Tamanho VARCHAR(5) NULL
		,Genero CHAR(1) NULL
		)
GO

INSERT INTO NovosProdutos
VALUES (
	'Mountain Bike Socks, M'
	,'Branco'
	,'9.50'
	,'M'
	,'U'
	)

INSERT INTO NovosProdutos
VALUES (
	'Mountain Bike Socks, L'
	,'Branco'
	,'9.50'
	,'G'
	,'U'
	)

INSERT INTO NovosProdutos
VALUES (
	'AWC Logo Cap'
	,'Colorido'
	,'8.99'
	,''
	,'U'
	)

INSERT INTO NovosProdutos
VALUES (
	'Long-Sleeve Logo Jersey, S'
	,'Colorido'
	,'49.99'
	,'P'
	,'U'
	)

INSERT INTO NovosProdutos
VALUES (
	'Long-Sleeve Logo Jersey, M'
	,'Colorido'
	,'49.99'
	,'M'
	,'U'
	)

INSERT INTO NovosProdutos
VALUES (
	'Long-Sleeve Logo Jersey, L'
	,'Colorido'
	,'49.99'
	,'G'
	,'U'
	)

INSERT INTO NovosProdutos
VALUES (
	'Long-Sleeve Logo Jersey, XL'
	,'Colorido'
	,'49.99'
	,'GG'
	,'U'
	)

INSERT INTO NovosProdutos
VALUES (
	'Mens Sports Shorts, S'
	,'Preto'
	,'59.99'
	,'P'
	,'M'
	)

INSERT INTO NovosProdutos
VALUES (
	'Mens Sports Shorts, M'
	,'Preto'
	,'59.99'
	,'M'
	,'M'
	)

INSERT INTO NovosProdutos
VALUES (
	'Mens Sports Shorts, L'
	,'Preto'
	,'59.99'
	,'G'
	,'M'
	)

INSERT INTO NovosProdutos
VALUES (
	'Mens Sports Shorts, XL'
	,'Preto'
	,'59.99'
	,'GG'
	,'M'
	)

INSERT INTO NovosProdutos
VALUES (
	'Womens Tights, S'
	,'Preto'
	,'74.99'
	,'P'
	,'F'
	)

INSERT INTO NovosProdutos
VALUES (
	'Womens Tights, M'
	,'Preto'
	,'74.99'
	,'M'
	,'F'
	)

INSERT INTO NovosProdutos
VALUES (
	'Womens Tights, L'
	,'Preto'
	,'74.99'
	,'G'
	,'F'
	)

INSERT INTO NovosProdutos
VALUES (
	'Mens Bib-Shorts, S'
	,'Colorido'
	,'89.99'
	,'P'
	,'M'
	)

INSERT INTO NovosProdutos
VALUES (
	'Mens Bib-Shorts, M'
	,'Colorido'
	,'89.99'
	,'M'
	,'M'
	)

INSERT INTO NovosProdutos
VALUES (
	'Mens Bib-Shorts, L'
	,'Colorido'
	,'89.99'
	,'G'
	,'M'
	)

INSERT INTO NovosProdutos
VALUES (
	'Half-Finger Gloves, S'
	,'Preto'
	,'24.49'
	,'P'
	,'U'
	)

INSERT INTO NovosProdutos
VALUES (
	'Half-Finger Gloves, M'
	,'Preto'
	,'24.49'
	,'M'
	,'U'
	)

INSERT INTO NovosProdutos
VALUES (
	'Half-Finger Gloves, L'
	,'Preto'
	,'24.49'
	,'G'
	,'U'
	)

INSERT INTO NovosProdutos
VALUES (
	'Full-Finger Gloves, S'
	,'Preto'
	,'37.99'
	,'P'
	,'U'
	)

INSERT INTO NovosProdutos
VALUES (
	'Full-Finger Gloves, M'
	,'Preto'
	,'37.99'
	,'M'
	,'U'
	)

INSERT INTO NovosProdutos
VALUES (
	'Full-Finger Gloves, L'
	,'Preto'
	,'37.99'
	,'G'
	,'U'
	)

INSERT INTO NovosProdutos
VALUES (
	'Classic Vest, S'
	,'Blue'
	,'63.50'
	,'P'
	,'U'
	)

INSERT INTO NovosProdutos
VALUES (
	'Classic Vest, M'
	,'Blue'
	,'63.50'
	,'M'
	,'U'
	)

INSERT INTO NovosProdutos
VALUES (
	'Classic Vest, L'
	,'Blue'
	,'63.50'
	,'G'
	,'U'
	)

INSERT INTO NovosProdutos
VALUES (
	'Womens Mountain Shorts, S'
	,'Preto'
	,'69.99'
	,'P'
	,'F'
	)

INSERT INTO NovosProdutos
VALUES (
	'Womens Mountain Shorts, M'
	,'Preto'
	,'69.99'
	,'M'
	,'F'
	)

INSERT INTO NovosProdutos
VALUES (
	'Womens Mountain Shorts, L'
	,'Preto'
	,'69.99'
	,'G'
	,'F'
	)

INSERT INTO NovosProdutos
VALUES (
	'Racing Socks, M'
	,'Branco'
	,'8.99'
	,'M'
	,'U'
	)

INSERT INTO NovosProdutos
VALUES (
	'Racing Socks, L'
	,'Branco'
	,'8.99'
	,'G'
	,'U'
	)

INSERT INTO NovosProdutos
VALUES (
	'Short-Sleeve Classic Jersey, S'
	,'Amarelo'
	,'53.99'
	,'P'
	,'U'
	)

INSERT INTO NovosProdutos
VALUES (
	'Short-Sleeve Classic Jersey, M'
	,'Amarelo'
	,'53.99'
	,'M'
	,'U'
	)

INSERT INTO NovosProdutos
VALUES (
	'Short-Sleeve Classic Jersey, L'
	,'Amarelo'
	,'53.99'
	,'G'
	,'U'
	)

INSERT INTO NovosProdutos
VALUES (
	'Short-Sleeve Classic Jersey, XL'
	,'Amarelo'
	,'53.99'
	,'GG'
	,'U'
	)
GO

-- Select da tabela NovosProdutos
SELECT *
FROM NovosProdutos