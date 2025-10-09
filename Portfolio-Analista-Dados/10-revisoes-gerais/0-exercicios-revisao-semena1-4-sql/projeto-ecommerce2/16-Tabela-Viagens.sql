
-- Estudos Sql na DIO // By Jehann Câmara
-- Criação da tabela Viagens

USE Viagens;

GO

DROP TABLE

IF EXISTS dbo.Usuarios
	CREATE TABLE Usuarios (
		IdUsuario INT IDENTITY(1, 1) PRIMARY KEY NOT NULL
		,NomeUsuario VARCHAR(50) NOT NULL
		,EmailUsuario VARCHAR(255) NULL
		,DataNascimento DATETIME2(7) NULL
		,Endereco VARCHAR(150) NULL
		)
GO

ALTER TABLE Usuarios ADD CONSTRAINT Pk_Usuario PRIMARY KEY (IdUsuario)