-- 🗃️ [01] SETUP INICIAL - DATABASE estudos_sql
-- PRIMEIRO script a ser executado - Database simples para Mês 1

PRINT '==========================================';
PRINT '🚀 INICIANDO SETUP ESTUDOS_SQL (01/03)';
PRINT '==========================================';

USE MASTER;
GO

-- 1. REMOVER DATABASE EXISTENTE (SE HOUVER)
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'estudos_sql')
BEGIN
    PRINT '📋 Removendo database estudos_sql existente...';
    ALTER DATABASE estudos_sql SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE estudos_sql;
    PRINT '✅ Database anterior removido.';
END
ELSE
BEGIN
    PRINT '📋 Nenhum database estudos_sql encontrado. Criando novo...';
END
GO

-- 2. CRIAR NOVO DATABASE
PRINT '📋 Criando database estudos_sql...';
CREATE DATABASE estudos_sql;
GO

PRINT '📋 Configurando database estudos_sql...';
USE estudos_sql;
GO

-- 3. CRIAR TABELAS BÁSICAS
PRINT '📋 Criando tabelas básicas...';

CREATE TABLE clientes (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    idade INT,
    cidade VARCHAR(50),
    data_cadastro DATE DEFAULT GETDATE(),
    ativo BIT DEFAULT 1
);
GO

CREATE TABLE produtos (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(50),
    preco DECIMAL(10,2),
    estoque INT DEFAULT 0
);
GO

CREATE TABLE pedidos (
    id INT PRIMARY KEY IDENTITY(1,1),
    cliente_id INT,
    produto_id INT,
    quantidade INT,
    valor_total DECIMAL(10,2),
    data_pedido DATE,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);
GO

-- 4. INSERIR DADOS DE EXEMPLO
PRINT '📋 Inserindo dados de exemplo...';

INSERT INTO clientes (nome, email, idade, cidade) VALUES
('Ana Silva', 'ana.silva@email.com', 28, 'São Paulo'),
('Carlos Oliveira', 'carlos.oliveira@email.com', 35, 'Rio de Janeiro'),
('Marina Santos', 'marina.santos@email.com', 22, 'Belo Horizonte'),
('João Pereira', 'joao.pereira@email.com', 42, 'São Paulo');
GO

INSERT INTO produtos (nome, categoria, preco, estoque) VALUES
('Notebook Dell', 'Eletrônicos', 2500.00, 15),
('Mouse Wireless', 'Acessórios', 89.90, 50),
('Teclado Mecânico', 'Acessórios', 299.90, 30);
GO

INSERT INTO pedidos (cliente_id, produto_id, quantidade, valor_total, data_pedido) VALUES
(1, 1, 1, 2500.00, '2024-02-01'),
(1, 2, 2, 179.80, '2024-02-01'),
(2, 3, 1, 299.90, '2024-02-02');
GO

-- 5. CRIAR VIEWS SIMPLES
PRINT '📋 Criando views...';
GO

CREATE VIEW vw_pedidos_detalhados AS
SELECT 
    p.id as pedido_id,
    c.nome as cliente_nome,
    c.cidade,
    pr.nome as produto,
    p.quantidade,
    p.valor_total,
    p.data_pedido
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.id
INNER JOIN produtos pr ON p.produto_id = pr.id;
GO

PRINT '==========================================';
PRINT '✅ SETUP ESTUDOS_SQL CONCLUÍDO (01/03)';
PRINT '==========================================';
PRINT '📊 Resumo:';
PRINT '   • Database: estudos_sql';
PRINT '   • Tabelas: 3 (clientes, produtos, pedidos)';
PRINT '   • Registros: 4 clientes, 3 produtos, 3 pedidos';
PRINT '   • Views: 1 (vw_pedidos_detalhados)';
PRINT '';
PRINT '🎯 PRÓXIMO: Execute 02_setup_roadmap_principal.sql';
PRINT '==========================================';
GO