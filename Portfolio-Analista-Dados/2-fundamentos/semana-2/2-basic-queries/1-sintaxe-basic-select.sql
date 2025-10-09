
-- Sintaxe básica // By Jehann Câmara

USE PortfolioProjects

-- Exclui a tabela se ela já existir e cria novamente a Tabela de Clientes
DROP TABLE

IF EXISTS dbo.Tabela1
	CREATE TABLE Tabela1 (
        id INT PRIMARY KEY IDENTITY(1,1),
        nome VARCHAR(200) NOT NULL,
        email VARCHAR(200) UNIQUE NOT NULL,
        cidade VARCHAR(100),
        data_cadastro DATE DEFAULT GETDATE()
);


SELECT id, nome, email, cidade, data_cadastro
FROM Tabela1
WHERE id > 1;