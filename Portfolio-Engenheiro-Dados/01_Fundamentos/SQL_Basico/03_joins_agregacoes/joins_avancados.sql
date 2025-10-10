
-- 📊 SQL Avançado - JOINs e Agregações
-- Mês 1: Fundamentos - Aula Avançada

-- ==========================================
-- 1. PREPARANDO DADOS DE EXEMPLO
-- ==========================================

USE estudos_sql;

-- Tabela de produtos
CREATE TABLE produtos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(50),
    preco_custo DECIMAL(10,2),
    preco_venda DECIMAL(10,2)
);

-- Tabela de vendas
CREATE TABLE vendas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    produto_id INT,
    quantidade INT,
    data_venda DATE,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

-- Inserindo produtos
INSERT INTO produtos (nome, categoria, preco_custo, preco_venda) VALUES
('Notebook Dell', 'Eletrônicos', 2000.00, 2500.00),
('Mouse Wireless', 'Acessórios', 50.00, 89.90),
('Teclado Mecânico', 'Acessórios', 150.00, 299.90),
('Monitor 24"', 'Eletrônicos', 600.00, 899.00),
('Tablet Samsung', 'Eletrônicos', 800.00, 1200.00);

-- Inserindo vendas
INSERT INTO vendas (cliente_id, produto_id, quantidade, data_venda) VALUES
(1, 1, 1, '2024-02-01'),
(1, 2, 2, '2024-02-01'),
(2, 3, 1, '2024-02-02'),
(3, 4, 1, '2024-02-03'),
(4, 5, 1, '2024-02-04'),
(2, 2, 1, '2024-02-05'),
(5, 1, 1, '2024-02-06');

-- ==========================================
-- 2. JOINS - RELACIONANDO TABELAS
-- ==========================================

-- INNER JOIN (apenas registros que existem em ambas)
SELECT 
    c.nome AS cliente,
    p.nome AS produto,
    v.quantidade,
    v.data_venda
FROM vendas v
INNER JOIN clientes c ON v.cliente_id = c.id
INNER JOIN produtos p ON v.produto_id = p.id;

-- LEFT JOIN (todos da esquerda + correspondentes direita)
SELECT 
    c.nome AS cliente,
    v.data_venda
FROM clientes c
LEFT JOIN vendas v ON c.id = v.cliente_id;

-- RIGHT JOIN (todos da direita + correspondentes esquerda)
SELECT 
    p.nome AS produto,
    v.quantidade
FROM vendas v
RIGHT JOIN produtos p ON v.produto_id = p.id;

-- ==========================================
-- 3. FUNÇÕES DE AGREGAÇÃO
-- ==========================================

-- COUNT - Contar registros
SELECT COUNT(*) AS total_clientes FROM clientes;
SELECT COUNT(*) AS clientes_sp FROM clientes WHERE cidade = 'São Paulo';

-- SUM - Soma de valores
SELECT 
    SUM(quantidade) AS total_itens_vendidos,
    SUM(quantidade * p.preco_venda) AS total_vendas
FROM vendas v
INNER JOIN produtos p ON v.produto_id = p.id;

-- AVG - Média
SELECT AVG(idade) AS media_idade FROM clientes;

-- MIN e MAX
SELECT 
    MIN(idade) AS idade_minima,
    MAX(idade) AS idade_maxima
FROM clientes;

-- ==========================================
-- 4. GROUP BY - AGRUPANDO DADOS
-- ==========================================

-- Vendas por cliente
SELECT 
    c.nome AS cliente,
    COUNT(v.id) AS total_compras,
    SUM(v.quantidade * p.preco_venda) AS total_gasto
FROM clientes c
LEFT JOIN vendas v ON c.id = v.cliente_id
LEFT JOIN produtos p ON v.produto_id = p.id
GROUP BY c.id, c.nome;

-- Vendas por produto
SELECT 
    p.nome AS produto,
    p.categoria,
    SUM(v.quantidade) AS total_vendido,
    SUM(v.quantidade * p.preco_venda) AS receita_total
FROM produtos p
LEFT JOIN vendas v ON p.id = v.produto_id
GROUP BY p.id, p.nome, p.categoria;

-- Vendas por cidade
SELECT 
    c.cidade,
    COUNT(v.id) AS total_vendas,
    SUM(v.quantidade * p.preco_venda) AS receita
FROM clientes c
LEFT JOIN vendas v ON c.id = v.cliente_id
LEFT JOIN produtos p ON v.produto_id = p.id
GROUP BY c.cidade;

-- ==========================================
-- 5. HAVING - FILTRANDO GRUPOS
-- ==========================================

-- Clientes que gastaram mais de 500
SELECT 
    c.nome,
    SUM(v.quantidade * p.preco_venda) AS total_gasto
FROM clientes c
INNER JOIN vendas v ON c.id = v.cliente_id
INNER JOIN produtos p ON v.produto_id = p.id
GROUP BY c.id, c.nome
HAVING total_gasto > 500;

-- Cidades com mais de 1 venda
SELECT 
    c.cidade,
    COUNT(v.id) AS total_vendas
FROM clientes c
INNER JOIN vendas v ON c.id = v.cliente_id
GROUP BY c.cidade
HAVING total_vendas > 1;

-- ==========================================
-- 6. SUBCONSULTAS (SUBQUERIES)
-- ==========================================

-- Clientes que nunca compraram
SELECT nome, email
FROM clientes
WHERE id NOT IN (SELECT DISTINCT cliente_id FROM vendas);

-- Produtos mais vendidos (top 3)
SELECT 
    nome,
    (SELECT SUM(quantidade) FROM vendas WHERE produto_id = produtos.id) AS total_vendido
FROM produtos
ORDER BY total_vendido DESC
LIMIT 3;

-- ==========================================
-- 🎯 EXERCÍCIOS PRÁTICOS
-- ==========================================

-- 1. Liste todos os clientes com seus totais gastos
-- 2. Mostre os produtos mais lucrativos (lucro = venda - custo)
-- 3. Encontre o cliente que mais comprou em quantidade
-- 4. Calcule a média de valor por venda por cidade
-- 5. Mostre produtos que nunca foram vendidos

-- ==========================================
-- 💡 DICAS PARA PRÁTICA
-- ==========================================

-- • Comece com INNER JOIN simples
-- • Use aliases para tornar queries mais legíveis
-- • Teste GROUP BY com uma coluna primeiro
-- • HAVING funciona como WHERE mas para grupos
