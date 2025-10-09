
-- Estudos Sql na DIO // By Jehann Câmara
-- transição da tabela Clientes

USE ecommerce;

BEGIN TRAN -- inicio de transi��o

UPDATE Clientes
SET aceitacomunicados = 0

--ROLLBACK  -- retornar para antes do inicio da transi��o
COMMIT -- comitar o begin, efetivar as mudan�as

SELECT *
FROM clientes