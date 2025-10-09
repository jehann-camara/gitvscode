-- =============================================
-- BANCO DE DADOS TECHSTORE - MÊS 1
-- Script completo com DROP IF EXISTS // By Jehann Câmara
-- =============================================

-- Verificar e remover o banco de dados se existir
USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'TechStore')
BEGIN
    ALTER DATABASE TechStore SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE TechStore;
END
GO

-- Criar banco de dados
CREATE DATABASE TechStore;
GO

USE TechStore;
GO

-- =============================================
-- CRIAÇÃO DAS TABELAS COM DROP CONDICIONAL
-- =============================================

-- Remover e criar tabela pedidos_itens (depende de pedidos e produtos)
IF OBJECT_ID('dbo.pedidos_itens', 'U') IS NOT NULL
    DROP TABLE dbo.pedidos_itens;
GO

-- Remover e criar tabela pedidos (depende de clientes)
IF OBJECT_ID('dbo.pedidos', 'U') IS NOT NULL
    DROP TABLE dbo.pedidos;
GO

-- Remover e criar tabela produtos (depende de categorias)
IF OBJECT_ID('dbo.produtos', 'U') IS NOT NULL
    DROP TABLE dbo.produtos;
GO

-- Remover e criar tabela clientes
IF OBJECT_ID('dbo.clientes', 'U') IS NOT NULL
    DROP TABLE dbo.clientes;
GO

-- Remover e criar tabela categorias
IF OBJECT_ID('dbo.categorias', 'U') IS NOT NULL
    DROP TABLE dbo.categorias;
GO

-- Criar tabela de Categorias
CREATE TABLE categorias (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100) NOT NULL,
    descricao TEXT
);
GO

-- Criar tabela de Clientes
CREATE TABLE clientes (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(200) NOT NULL,
    email VARCHAR(200) UNIQUE NOT NULL,
    cidade VARCHAR(100),
    data_cadastro DATE DEFAULT GETDATE()
);
GO

-- Criar tabela de Produtos
CREATE TABLE produtos (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(200) NOT NULL,
    categoria_id INT,
    preco DECIMAL(10,2) NOT NULL,
    custo DECIMAL(10,2) NOT NULL,
    estoque INT DEFAULT 0,
    data_cadastro DATE DEFAULT GETDATE(),
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);
GO

-- Criar tabela de Pedidos
CREATE TABLE pedidos (
    id INT PRIMARY KEY IDENTITY(1,1),
    cliente_id INT NOT NULL,
    data_pedido DATE NOT NULL,
    status VARCHAR(50) DEFAULT 'Pendente',
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);
GO

-- Criar tabela de Itens do Pedido
CREATE TABLE pedidos_itens (
    id INT PRIMARY KEY IDENTITY(1,1),
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);
GO

-- =============================================
-- INSERÇÃO DE DADOS DE EXEMPLO
-- =============================================

-- Inserir Categorias
INSERT INTO categorias (nome, descricao) VALUES
('Smartphones', 'Telefones inteligentes e acessórios'),
('Notebooks', 'Computadores portáteis'),
('Tablets', 'Tablets e iPads'),
('Acessórios', 'Capas, fones, carregadores'),
('Games', 'Consoles e jogos');
GO

-- Inserir Clientes
INSERT INTO clientes (nome, email, cidade) VALUES
('João Silva', 'joao.silva@email.com', 'São Paulo'),
('Maria Santos', 'maria.santos@email.com', 'Rio de Janeiro'),
('Pedro Costa', 'pedro.costa@email.com', 'Belo Horizonte'),
('Ana Oliveira', 'ana.oliveira@email.com', 'São Paulo'),
('Carlos Souza', 'carlos.souza@email.com', 'Curitiba'),
('Juliana Lima', 'juliana.lima@email.com', 'Porto Alegre'),
('Roberto Alves', 'roberto.alves@email.com', 'Salvador'),
('Fernanda Rocha', 'fernanda.rocha@email.com', 'Recife');
GO

-- Inserir Produtos
INSERT INTO produtos (nome, categoria_id, preco, custo, estoque) VALUES
('iPhone 14', 1, 5000.00, 3500.00, 50),
('Samsung Galaxy S23', 1, 3500.00, 2500.00, 30),
('MacBook Air M2', 2, 8000.00, 6000.00, 20),
('iPad Pro', 3, 4500.00, 3200.00, 25),
('Capa iPhone 14', 4, 150.00, 50.00, 100),
('Fone Bluetooth Sony', 4, 300.00, 120.00, 80),
('Dell XPS 13', 2, 6000.00, 4500.00, 15),
('Samsung Tab S8', 3, 3200.00, 2400.00, 35),
('Carregador Wireless', 4, 200.00, 80.00, 60),
('PlayStation 5', 5, 4500.00, 3500.00, 10),
('Xbox Series X', 5, 4200.00, 3300.00, 8);
GO

-- Inserir Pedidos
INSERT INTO pedidos (cliente_id, data_pedido, status, total) VALUES
(1, '2024-01-15', 'Entregue', 5150.00),
(2, '2024-01-20', 'Entregue', 3500.00),
(3, '2024-02-01', 'Processando', 8000.00),
(1, '2024-02-05', 'Entregue', 150.00),
(4, '2024-02-10', 'Entregue', 4700.00),
(5, '2024-02-12', 'Cancelado', 300.00),
(6, '2024-02-15', 'Entregue', 8700.00),
(2, '2024-02-18', 'Processando', 200.00),
(7, '2024-02-20', 'Pendente', 4500.00),
(8, '2024-02-22', 'Entregue', 3200.00);
GO

-- Inserir Itens dos Pedidos
INSERT INTO pedidos_itens (pedido_id, produto_id, quantidade, preco_unitario) VALUES
-- Pedido 1: João Silva comprou iPhone + Capa
(1, 1, 1, 5000.00),
(1, 5, 1, 150.00),

-- Pedido 2: Maria Santos comprou Samsung Galaxy
(2, 2, 1, 3500.00),

-- Pedido 3: Pedro Costa comprou MacBook
(3, 3, 1, 8000.00),

-- Pedido 4: João Silva comprou outra Capa
(4, 5, 1, 150.00),

-- Pedido 5: Ana Oliveira comprou iPad Pro + Fone
(5, 4, 1, 4500.00),
(5, 6, 1, 200.00),

-- Pedido 6: Carlos Souza (cancelado) - Fone
(6, 6, 1, 300.00),

-- Pedido 7: Juliana Lima comprou Dell XPS + Acessórios
(7, 7, 1, 6000.00),
(7, 9, 2, 200.00),
(7, 6, 1, 300.00),

-- Pedido 8: Maria Santos comprou Carregador
(8, 9, 1, 200.00),

-- Pedido 9: Roberto Alves comprou PlayStation
(9, 10, 1, 4500.00),

-- Pedido 10: Fernanda Rocha comprou Samsung Tab
(10, 8, 1, 3200.00);
GO

-- =============================================
-- CONSULTAS DE VERIFICAÇÃO
-- =============================================

-- Verificar dados inseridos
PRINT '=== VERIFICAÇÃO DE DADOS INSERIDOS ===';
SELECT 'Categorias' as Tabela, COUNT(*) as Total FROM categorias
UNION ALL
SELECT 'Clientes', COUNT(*) FROM clientes
UNION ALL
SELECT 'Produtos', COUNT(*) FROM produtos
UNION ALL
SELECT 'Pedidos', COUNT(*) FROM pedidos
UNION ALL
SELECT 'Pedidos Itens', COUNT(*) FROM pedidos_itens;
GO

-- Visualizar algumas linhas de cada tabela
PRINT '=== VISUALIZAÇÃO DOS DADOS ===';
SELECT TOP 3 * FROM clientes;
SELECT * FROM categorias;
SELECT TOP 3 * FROM produtos;
SELECT TOP 3 * FROM pedidos;
SELECT TOP 5 * FROM pedidos_itens;
GO

-- =============================================
-- MENSAGEM DE SUCESSO
-- =============================================

PRINT '=========================================';
PRINT '✅ BANCO TECHStore CRIADO COM SUCESSO!';
PRINT '✅ TODAS AS TABELAS FORAM CRIADAS E POPULADAS';
PRINT '✅ PRONTO PARA OS EXERCÍCIOS DO MÊS 1';
PRINT '=========================================';
GO