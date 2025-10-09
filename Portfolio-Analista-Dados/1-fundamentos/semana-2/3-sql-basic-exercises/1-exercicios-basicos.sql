
-- 📝 Exercícios Básicos de SQL - Semana 2 // By Jehann Câmara
-- Dataset: Loja Virtual Simples

USE PortfolioProjects;
USE ecommerce;

-- 1. SELEÇÃO SIMPLES
-- Selecionar todos os produtos
SELECT * FROM produtos;

-- 2. SELEÇÃO COM FILTRO
-- Produtos com preço maior que R$ 100
SELECT nome, preço 
FROM produtos 
WHERE preço > 100;

-- 3. ORDENAÇÃO
-- Produtos ordenados por nome (A-Z)
SELECT * FROM produtos ORDER BY nome;

-- 4. LIMITE DE RESULTADOS
-- Primeiros 5 produtos mais caros
SELECT TOP 5 nome, preço 
FROM produtos 
ORDER BY preço DESC;

-- 5. FILTRO COM MÚLTIPLAS CONDIÇÕES
-- Produtos da categoria 'Eletrônicos' com estoque disponível
SELECT nome, preço, estoque 
FROM produtos 
WHERE categoria = 'Eletrônicos' AND estoque > 0;

-- 6. VALORES DISTINTOS
-- Cidades únicas onde temos clientes
SELECT DISTINCT cidade FROM clientes;

-- 7. CÁLCULOS SIMPLES
-- Calcular valor total do estoque por produto
SELECT nome, preço, estoque, (preço * estoque) as valor_total_estoque
FROM produtos;

-- 8. FILTRO COM TEXTO
-- Clientes cujo nome começa com 'A'
SELECT nome, email 
FROM clientes 
WHERE nome LIKE 'A%';

-- 9. COMBINAÇÃO DE CONCEITOS
-- Produtos entre R$ 50 e R$ 200, ordenados por categoria e preço
SELECT nome, categoria, preço 
FROM produtos 
WHERE preço BETWEEN 50 AND 200 
ORDER BY categoria, preço DESC;

-- 10. CONTAGEM BÁSICA
-- Quantos produtos temos no total?
SELECT COUNT(*) as total_produtos FROM produtos;