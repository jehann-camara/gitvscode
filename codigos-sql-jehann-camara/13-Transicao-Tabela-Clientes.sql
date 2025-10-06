
-- Estudos Sql na DIO // By Jehann Câmara
-- transição da tabela Clientes
USE ecommerce

BEGIN TRAN -- inicio de transição

UPDATE Clientes
SET aceitacomunicados = 0

--ROLLBACK  -- retornar para antes do inicio da transição
COMMIT -- comitar o begin, efetivar as mudanças

SELECT *
FROM clientes