
-- Selects básicos // By Jehann Câmara

use techstore

-- 1. Selecionar todas as colunas de uma tabela
SELECT * FROM produtos; -- alt + f1 ( atalho para Metadados sobre a tabela).

-- 2. Selecionar colunas espec�ficas
SELECT nome, Preco FROM produtos;

-- 3. Consulta com filtro simples
SELECT * FROM clientes WHERE cidade = 'São Paulo';

-- 4. Ordenar por pre�o (crescente)
SELECT * FROM produtos ORDER BY Preco;

-- 5. Ordenar por pre�o (decrescente)
SELECT * FROM produtos ORDER BY Preco DESC;

-- 6. Limitar resultados
SELECT TOP 5 * FROM produtos

-- 7. Maior que
SELECT * FROM produtos WHERE Preco > 100;

-- 8. Entre valores
SELECT * FROM produtos WHERE Preco BETWEEN 50 AND 200;

-- 9. M�ltiplas condi��es
SELECT * FROM produtos WHERE categoria_id >1 AND preco < 500;

-- 10. Listar todos os produtos com id de categoria > 5
SELECT * FROM produtos WHERE categoria_id >5;

-- 11. Encontrar clientes de uma cidade específica
SELECT nome, email FROM clientes WHERE cidade = 'Rio de Janeiro';

-- 12. Produtos com pre�o acima de R$ 200, ordenados do mais caro para o mais barato
SELECT nome, Preco FROM produtos 
WHERE Preco > 200 
ORDER BY Preco DESC;

