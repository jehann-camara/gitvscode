-- 📚 SQL Básico - SELECT e WHERE
-- Mês 1: Fundamentos - Aula 2

-- ==========================================
-- 1. CRIANDO TABELA DE EXEMPLO
-- ==========================================

CREATE DATABASE estudos_sql;
USE estudos_sql;

CREATE TABLE clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    idade INT,
    cidade VARCHAR(50),
    data_cadastro DATE,
    ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE pedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    produto VARCHAR(100),
    valor DECIMAL(10,2),
    data_pedido DATE,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- ==========================================
-- 2. INSERINDO DADOS DE EXEMPLO
-- ==========================================

INSERT INTO clientes (nome, email, idade, cidade, data_cadastro) VALUES
('Ana Silva', 'ana.silva@email.com', 28, 'São Paulo', '2024-01-15'),
('Carlos Oliveira', 'carlos.oliveira@email.com', 35, 'Rio de Janeiro', '2024-01-20'),
('Marina Santos', 'marina.santos@email.com', 22, 'Belo Horizonte', '2024-02-01'),
('João Pereira', 'joao.pereira@email.com', 42, 'São Paulo', '2024-02-10'),
('Juliana Costa', 'juliana.costa@email.com', 29, 'Curitiba', '2024-02-15'),
('Ricardo Alves', 'ricardo.alves@email.com', 31, 'Porto Alegre', '2024-02-20');

INSERT INTO pedidos (cliente_id, produto, valor, data_pedido) VALUES
(1, 'Notebook Dell', 2500.00, '2024-02-01'),
(1, 'Mouse Wireless', 89.90, '2024-02-02'),
(2, 'Teclado Mecânico', 299.90, '2024-02-03'),
(3, 'Monitor 24"', 899.00, '2024-02-05'),
(4, 'Impressora Laser', 650.00, '2024-02-08'),
(5, 'Tablet Samsung', 1200.00, '2024-02-10'),
(2, 'Webcam HD', 159.90, '2024-02-12');

-- ==========================================
-- 3. CONSULTAS BÁSICAS COM SELECT
-- ==========================================

-- Selecionar todas as colunas
SELECT * FROM clientes;

-- Selecionar colunas específicas
SELECT nome, idade, cidade FROM clientes;

-- Selecionar com alias (apelidos)
SELECT 
    nome AS 'Nome do Cliente',
    idade AS 'Idade',
    cidade AS 'Cidade'
FROM clientes;

-- ==========================================
-- 4. FILTROS COM WHERE
-- ==========================================

-- Clientes de São Paulo
SELECT * FROM clientes WHERE cidade = 'São Paulo';

-- Clientes com mais de 30 anos
SELECT nome, idade FROM clientes WHERE idade > 30;

-- Clientes entre 25 e 35 anos
SELECT nome, idade FROM clientes WHERE idade BETWEEN 25 AND 35;

-- Clientes de São Paulo ou Rio de Janeiro
SELECT nome, cidade FROM clientes 
WHERE cidade IN ('São Paulo', 'Rio de Janeiro');

-- Clientes cujo nome começa com 'A'
SELECT nome FROM clientes WHERE nome LIKE 'A%';

-- Clientes cujo nome contém 'Santos'
SELECT nome FROM clientes WHERE nome LIKE '%Santos%';

-- ==========================================
-- 5. OPERADORES LÓGICOS
-- ==========================================

-- Clientes de São Paulo com mais de 25 anos
SELECT nome, idade, cidade 
FROM clientes 
WHERE cidade = 'São Paulo' AND idade > 25;

-- Clientes de São Paulo OU com mais de 30 anos
SELECT nome, idade, cidade 
FROM clientes 
WHERE cidade = 'São Paulo' OR idade > 30;

-- Clientes que NÃO são de São Paulo
SELECT nome, cidade 
FROM clientes 
WHERE cidade != 'São Paulo';

-- ==========================================
-- 6. ORDENAÇÃO COM ORDER BY
-- ==========================================

-- Ordenar por nome (ascendente)
SELECT nome, idade FROM clientes ORDER BY nome;

-- Ordenar por idade (descendente)
SELECT nome, idade FROM clientes ORDER BY idade DESC;

-- Ordenar por cidade e depois por nome
SELECT nome, cidade FROM clientes ORDER BY cidade, nome;

-- ==========================================
-- 7. LIMITANDO RESULTADOS
-- ==========================================

-- Primeiros 3 clientes
SELECT * FROM clientes LIMIT 3;

-- Clientes a partir do 2º, limitando a 3 resultados
SELECT * FROM clientes LIMIT 1, 3;

-- ==========================================
-- 🎯 EXERCÍCIOS PRÁTICOS
-- ==========================================

-- 1. Selecione todos os clientes de Belo Horizonte
-- 2. Encontre clientes com idade menor que 30 anos
-- 3. Liste clientes em ordem alfabética de cidade
-- 4. Selecione os 2 clientes mais jovens
-- 5. Encontre clientes cujo email termina com '.com'

-- ==========================================
-- DICAS PARA PRÁTICA:
-- ==========================================
-- • Execute cada consulta individualmente
-- • Experimente modificar os filtros
-- • Crie suas próprias consultas
-- • Use o ORDER BY para diferentes colunas