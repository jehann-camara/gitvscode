
-- Estudos Sql na DIO // By Jehann C�mara
-- Cria��o da tabela Clientes // ecommerce

USE ecommerce;
GO

DROP TABLE

IF EXISTS dbo.Clientes
	CREATE TABLE Clientes (
		IdCliente INT IDENTITY(1, 1) PRIMARY KEY NOT NULL
		,NomeCliente VARCHAR(255) NOT NULL
		,SobrenomeCliente VARCHAR(255) NULL
		,EmailCliente VARCHAR(255) NULL
		,AceitaComunicados BIT NULL
		,DataCadastro Datetime2(7) NULL
		,TipoPessoa CHAR(1) NOT NULL
		)
GO

-- Inser��o de dados
INSERT INTO Clientes
VALUES (
	'Ken'
	,'S�nchez'
	,'email@email.com'
	,0
	,'Jan  7 2009 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Terri'
	,'Duffy'
	,'email@email.com'
	,1
	,'Jan 24 2008 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Roberto'
	,'Tamburello'
	,'email@email.com'
	,0
	,'Nov  4 2007 12:00AM'
	,'J'
	)

INSERT INTO Clientes
VALUES (
	'Rob'
	,'Walters'
	,'email@email.com'
	,0
	,'Nov 28 2007 12:00AM'
	,'J'
	)

INSERT INTO Clientes
VALUES (
	'Gigi'
	,'Matthew'
	,'email@email.com'
	,0
	,'Jan  9 2009 12:00AM'
	,'J'
	)

INSERT INTO Clientes
VALUES (
	'Ovidiu'
	,'Cracium'
	,'email@email.com'
	,0
	,'Nov 28 2010 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Mary'
	,'Gibson'
	,'email@email.com'
	,0
	,'Jan  5 2009 12:00AM'
	,'J'
	)

INSERT INTO Clientes
VALUES (
	'Jill'
	,'Williams'
	,'email@email.com'
	,0
	,'Jan 11 2009 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'James'
	,'Hamilton'
	,'email@email.com'
	,0
	,'Jan 27 2009 12:00AM'
	,'J'
	)

INSERT INTO Clientes
VALUES (
	'Peter'
	,'Krebs'
	,'email@email.com'
	,0
	,'Nov 24 2008 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Guy'
	,'Gilbert'
	,'email@email.com'
	,0
	,'Jun 23 2006 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Mark'
	,'McArthur'
	,'email@email.com'
	,1
	,'Jan 16 2009 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Britta'
	,'Simon'
	,'email@email.com'
	,0
	,'Jan 22 2009 12:00AM'
	,'J'
	)

INSERT INTO Clientes
VALUES (
	'Ed'
	,'Dudenhoefer'
	,'email@email.com'
	,0
	,'Jan 29 2010 12:00AM'
	,'J'
	)

INSERT INTO Clientes
VALUES (
	'Bryan'
	,'Baker'
	,'email@email.com'
	,0
	,'Jan 14 2009 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Barry'
	,'Johnson'
	,'email@email.com'
	,0
	,'Nov 29 2013 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Sidney'
	,'Higa'
	,'email@email.com'
	,0
	,'Jan 26 2008 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Doris'
	,'Hartwig'
	,'email@email.com'
	,0
	,'Jan 31 2014 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Denise'
	,'Smith'
	,'email@email.com'
	,0
	,'Jan 29 2009 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Diane'
	,'Tibbott'
	,'email@email.com'
	,0
	,'Jan 11 2009 12:00AM'
	,'J'
	)

INSERT INTO Clientes
VALUES (
	'Maciej'
	,'Dusza'
	,'email@email.com'
	,0
	,'Jan 22 2010 12:00AM'
	,'J'
	)

INSERT INTO Clientes
VALUES (
	'Michiko'
	,'Osada'
	,'email@email.com'
	,0
	,'Jan 19 2009 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Eric'
	,'Brown'
	,'email@email.com'
	,0
	,'Jan 17 2010 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Frank'
	,'Martinez'
	,'email@email.com'
	,1
	,'Jan 29 2010 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Patrick'
	,'Wedge'
	,'email@email.com'
	,0
	,'Jan 25 2010 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Kimberly'
	,'Zimmerman'
	,'email@email.com'
	,0
	,'Jan  5 2010 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Tom'
	,'Vande Velde'
	,'email@email.com'
	,0
	,'Mar  3 2010 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Lolan'
	,'Song'
	,'email@email.com'
	,1
	,'Jan  5 2009 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Zheng'
	,'Mu'
	,'email@email.com'
	,0
	,'Nov 26 2008 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Alice'
	,'Ciccu'
	,'email@email.com'
	,1
	,'Nov 30 2008 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Mindaugas'
	,'Krapauskas'
	,'email@email.com'
	,1
	,'Jan  6 2009 12:00AM'
	,'J'
	)

INSERT INTO Clientes
VALUES (
	'Michael'
	,'Patten'
	,'email@email.com'
	,0
	,'Jan 24 2009 12:00AM'
	,'J'
	)

INSERT INTO Clientes
VALUES (
	'Vamsi'
	,'Kuppa'
	,'email@email.com'
	,0
	,'Nov 30 2008 12:00AM'
	,'J'
	)

INSERT INTO Clientes
VALUES (
	'Matthias'
	,'Berndt'
	,'email@email.com'
	,0
	,'Jan 13 2009 12:00AM'
	,'J'
	)

INSERT INTO Clientes
VALUES (
	'Ivo'
	,'Salmre'
	,'email@email.com'
	,0
	,'Nov 27 2008 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Samantha'
	,'Smith'
	,'email@email.com'
	,0
	,'Jan 28 2009 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Prasanna'
	,'Samarawickrama'
	,'email@email.com'
	,1
	,'Jan 15 2010 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Min'
	,'Su'
	,'email@email.com'
	,0
	,'Jan 17 2010 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Cynthia'
	,'Randall'
	,'email@email.com'
	,0
	,'Jan 20 2009 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Jian Shuo'
	,'Wang'
	,'email@email.com'
	,0
	,'Nov 30 2008 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Jason'
	,'Watters'
	,'email@email.com'
	,0
	,'Jan  7 2009 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Andy'
	,'Ruth'
	,'email@email.com'
	,1
	,'Jan 24 2009 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Yuhong'
	,'Li'
	,'email@email.com'
	,1
	,'Jan 25 2009 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Lane'
	,'Sacksteder'
	,'email@email.com'
	,1
	,'Jan  4 2009 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Linda'
	,'Randall'
	,'email@email.com'
	,0
	,'Jan 27 2009 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Jeff'
	,'Hay'
	,'email@email.com'
	,1
	,'Jan 14 2009 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'David'
	,'Johnson'
	,'email@email.com'
	,0
	,'Nov 25 2008 12:00AM'
	,'F'
	)

INSERT INTO Clientes
VALUES (
	'Reed'
	,'Koch'
	,'email@email.com'
	,0
	,'Jan 26 2009 12:00AM'
	,'J'
	)

-- Select da tabela Clientes
SELECT *
FROM Clientes