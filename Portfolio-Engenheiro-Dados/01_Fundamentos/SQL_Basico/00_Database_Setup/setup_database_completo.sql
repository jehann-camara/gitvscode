-- 🗃️ SETUP COMPLETO - BANCO DE DADOS ROADMAP ENGENHARIA DE DADOS
-- Script para criar toda a estrutura do banco que usaremos nos 7 meses

-- ==========================================
-- 1. CRIAÇÃO DO BANCO E SCHEMAS
-- ==========================================

-- Criar banco de dados principal
CREATE DATABASE RoadmapEngenhariaDados;
GO

USE RoadmapEngenhariaDados;
GO

-- Schema para dados brutos (Bronze Layer)
CREATE SCHEMA bronze;
GO

-- Schema para dados processados (Silver Layer)  
CREATE SCHEMA silver;
GO

-- Schema para dados analíticos (Gold Layer)
CREATE SCHEMA gold;
GO

-- Schema para utilitários e controle
CREATE SCHEMA util;
GO

-- ==========================================
-- 2. TABELAS DO MÊS 1-2 (FUNDAMENTOS)
-- ==========================================

-- Tabela de clientes (usada nos exercícios de SQL)
CREATE TABLE bronze.clientes (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    idade INT,
    cidade VARCHAR(50),
    estado CHAR(2),
    data_cadastro DATE DEFAULT GETDATE(),
    ativo BIT DEFAULT 1,
    data_criacao DATETIME2 DEFAULT GETDATE(),
    data_atualizacao DATETIME2 DEFAULT GETDATE()
);

-- Tabela de produtos
CREATE TABLE bronze.produtos (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(50),
    subcategoria VARCHAR(50),
    preco_custo DECIMAL(10,2),
    preco_venda DECIMAL(10,2),
    estoque INT DEFAULT 0,
    data_criacao DATETIME2 DEFAULT GETDATE(),
    data_atualizacao DATETIME2 DEFAULT GETDATE()
);

-- Tabela de vendas
CREATE TABLE bronze.vendas (
    id INT PRIMARY KEY IDENTITY(1,1),
    cliente_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10,2),
    valor_total DECIMAL(10,2),
    data_venda DATE NOT NULL,
    canal_venda VARCHAR(20),
    data_criacao DATETIME2 DEFAULT GETDATE(),
    
    CONSTRAINT fk_vendas_cliente FOREIGN KEY (cliente_id) REFERENCES bronze.clientes(id),
    CONSTRAINT fk_vendas_produto FOREIGN KEY (produto_id) REFERENCES bronze.produtos(id)
);

-- ==========================================
-- 3. TABELAS DO MÊS 3-4 (AZURE & MODELAGEM)
-- ==========================================

-- Tabela para logs de processamento (usada no Azure Data Factory)
CREATE TABLE util.processamento_logs (
    id BIGINT PRIMARY KEY IDENTITY(1,1),
    processo VARCHAR(100) NOT NULL,
    descricao VARCHAR(500),
    status VARCHAR(20) NOT NULL,
    linhas_processadas INT,
    data_inicio DATETIME2 NOT NULL,
    data_fim DATETIME2,
    duracao_segundos AS DATEDIFF(SECOND, data_inicio, ISNULL(data_fim, GETDATE())),
    erro_mensagem VARCHAR(1000)
);

-- Tabela de parâmetros do sistema
CREATE TABLE util.parametros_sistema (
    id INT PRIMARY KEY IDENTITY(1,1),
    chave VARCHAR(50) UNIQUE NOT NULL,
    valor VARCHAR(500),
    descricao VARCHAR(200),
    data_atualizacao DATETIME2 DEFAULT GETDATE()
);

-- ==========================================
-- 4. TABELAS DO MÊS 4-5 (MODELAGEM DIMENSIONAL)
-- ==========================================

-- DIMENSÃO Clientes (Gold Layer)
CREATE TABLE gold.dim_clientes (
    cliente_key INT PRIMARY KEY IDENTITY(1,1),
    cliente_id INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    idade INT,
    faixa_etaria VARCHAR(20),
    cidade VARCHAR(50),
    estado CHAR(2),
    data_cadastro DATE,
    cliente_ativo BIT,
    data_carregamento DATETIME2 DEFAULT GETDATE(),
    versao INT DEFAULT 1
);

-- DIMENSÃO Produtos (Gold Layer)
CREATE TABLE gold.dim_produtos (
    produto_key INT PRIMARY KEY IDENTITY(1,1),
    produto_id INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(50),
    subcategoria VARCHAR(50),
    preco_venda DECIMAL(10,2),
    data_carregamento DATETIME2 DEFAULT GETDATE(),
    versao INT DEFAULT 1
);

-- DIMENSÃO Tempo (Gold Layer)
CREATE TABLE gold.dim_tempo (
    data_key INT PRIMARY KEY, -- Formato YYYYMMDD
    data_completa DATE NOT NULL,
    dia INT,
    mes INT,
    ano INT,
    trimestre INT,
    nome_mes VARCHAR(20),
    nome_dia_semana VARCHAR(20),
    fim_de_semana BIT,
    feriado BIT DEFAULT 0,
    data_carregamento DATETIME2 DEFAULT GETDATE()
);

-- FATOS Vendas (Gold Layer)
CREATE TABLE gold.fato_vendas (
    venda_key BIGINT PRIMARY KEY IDENTITY(1,1),
    cliente_key INT NOT NULL,
    produto_key INT NOT NULL,
    data_key INT NOT NULL,
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    canal_venda VARCHAR(20),
    data_venda DATE NOT NULL,
    data_carregamento DATETIME2 DEFAULT GETDATE(),
    
    CONSTRAINT fk_fato_cliente FOREIGN KEY (cliente_key) REFERENCES gold.dim_clientes(cliente_key),
    CONSTRAINT fk_fato_produto FOREIGN KEY (produto_key) REFERENCES gold.dim_produtos(produto_key),
    CONSTRAINT fk_fato_tempo FOREIGN KEY (data_key) REFERENCES gold.dim_tempo(data_key)
);

-- ==========================================
-- 5. TABELAS DO MÊS 6-7 (PROJETOS AVANÇADOS)
-- ==========================================

-- Tabela para dados de APIs externas
CREATE TABLE bronze.dados_externos (
    id BIGINT PRIMARY KEY IDENTITY(1,1),
    fonte VARCHAR(100) NOT NULL,
    tipo_dado VARCHAR(50),
    dados_json NVARCHAR(MAX),
    data_extracao DATETIME2 NOT NULL,
    data_carregamento DATETIME2 DEFAULT GETDATE()
);

-- Tabela para métricas de qualidade de dados
CREATE TABLE util.metricas_qualidade (
    id BIGINT PRIMARY KEY IDENTITY(1,1),
    tabela VARCHAR(100) NOT NULL,
    metrica VARCHAR(100) NOT NULL,
    valor DECIMAL(15,2),
    data_medicao DATE NOT NULL,
    data_carregamento DATETIME2 DEFAULT GETDATE()
);

-- ==========================================
-- 6. INSERÇÃO DE DADOS DE EXEMPLO
-- ==========================================

-- Inserir clientes
INSERT INTO bronze.clientes (nome, email, idade, cidade, estado, data_cadastro) VALUES
('Ana Silva', 'ana.silva@email.com', 28, 'São Paulo', 'SP', '2024-01-15'),
('Carlos Oliveira', 'carlos.oliveira@email.com', 35, 'Rio de Janeiro', 'RJ', '2024-01-20'),
('Marina Santos', 'marina.santos@email.com', 22, 'Belo Horizonte', 'MG', '2024-02-01'),
('João Pereira', 'joao.pereira@email.com', 42, 'São Paulo', 'SP', '2024-02-10'),
('Juliana Costa', 'juliana.costa@email.com', 29, 'Curitiba', 'PR', '2024-02-15'),
('Ricardo Alves', 'ricardo.alves@email.com', 31, 'Porto Alegre', 'RS', '2024-02-20'),
('Fernanda Lima', 'fernanda.lima@email.com', 26, 'Salvador', 'BA', '2024-03-01'),
('Roberto Souza', 'roberto.souza@email.com', 38, 'Fortaleza', 'CE', '2024-03-05');

-- Inserir produtos
INSERT INTO bronze.produtos (nome, categoria, subcategoria, preco_custo, preco_venda, estoque) VALUES
('Notebook Dell i5', 'Eletrônicos', 'Computadores', 2000.00, 2500.00, 15),
('Mouse Wireless Logitech', 'Acessórios', 'Periféricos', 50.00, 89.90, 50),
('Teclado Mecânico RGB', 'Acessórios', 'Periféricos', 150.00, 299.90, 30),
('Monitor 24" Samsung', 'Eletrônicos', 'Monitores', 600.00, 899.00, 20),
('Tablet Samsung S6', 'Eletrônicos', 'Tablets', 800.00, 1200.00, 10),
('Impressora Laser HP', 'Eletrônicos', 'Impressoras', 450.00, 650.00, 8),
('Webcam Full HD', 'Acessórios', 'Periféricos', 80.00, 159.90, 25),
('SSD 500GB Kingston', 'Componentes', 'Armazenamento', 200.00, 349.90, 40);

-- Inserir vendas
INSERT INTO bronze.vendas (cliente_id, produto_id, quantidade, valor_unitario, valor_total, data_venda, canal_venda) VALUES
(1, 1, 1, 2500.00, 2500.00, '2024-02-01', 'Online'),
(1, 2, 2, 89.90, 179.80, '2024-02-01', 'Online'),
(2, 3, 1, 299.90, 299.90, '2024-02-02', 'Loja Física'),
(3, 4, 1, 899.00, 899.00, '2024-02-03', 'Online'),
(4, 5, 1, 1200.00, 1200.00, '2024-02-04', 'Loja Física'),
(2, 2, 1, 89.90, 89.90, '2024-02-05', 'Online'),
(5, 1, 1, 2500.00, 2500.00, '2024-02-06', 'Online'),
(6, 6, 1, 650.00, 650.00, '2024-02-07', 'Loja Física'),
(7, 7, 1, 159.90, 159.90, '2024-02-08', 'Online'),
(8, 8, 2, 349.90, 699.80, '2024-02-09', 'Online');

-- Inserir dados na dimensão tempo (exemplo para 2024)
INSERT INTO gold.dim_tempo (data_key, data_completa, dia, mes, ano, trimestre, nome_mes, nome_dia_semana, fim_de_semana)
SELECT 
    CONVERT(INT, CONVERT(VARCHAR, data, 112)) as data_key,
    data as data_completa,
    DAY(data) as dia,
    MONTH(data) as mes,
    YEAR(data) as ano,
    DATEPART(QUARTER, data) as trimestre,
    DATENAME(MONTH, data) as nome_mes,
    DATENAME(WEEKDAY, data) as nome_dia_semana,
    CASE WHEN DATEPART(WEEKDAY, data) IN (1, 7) THEN 1 ELSE 0 END as fim_de_semana
FROM (
    SELECT DATEADD(DAY, number, '2024-01-01') as data
    FROM master..spt_values 
    WHERE type = 'P' 
    AND DATEADD(DAY, number, '2024-01-01') BETWEEN '2024-01-01' AND '2024-12-31'
) datas;

-- Inserir parâmetros do sistema
INSERT INTO util.parametros_sistema (chave, valor, descricao) VALUES
('EMAIL_NOTIFICACAO', 'admin@empresa.com', 'Email para notificações do sistema'),
('DIAS_RETENCAO_LOGS', '30', 'Dias para manter logs no sistema'),
('LIMITE_BACKUP_GB', '50', 'Limite em GB para backups'),
('URL_API_DADOS', 'https://api.dados.gov.br', 'URL da API de dados externos');

-- ==========================================
-- 7. CRIAÇÃO DE ÍNDICES PARA PERFORMANCE
-- ==========================================

-- Índices para tabelas de bronze
CREATE INDEX ix_clientes_cidade ON bronze.clientes(cidade);
CREATE INDEX ix_clientes_data_cadastro ON bronze.clientes(data_cadastro);
CREATE INDEX ix_produtos_categoria ON bronze.produtos(categoria);
CREATE INDEX ix_vendas_data_venda ON bronze.vendas(data_venda);
CREATE INDEX ix_vendas_cliente_id ON bronze.vendas(cliente_id);
CREATE INDEX ix_vendas_produto_id ON bronze.vendas(produto_id);

-- Índices para tabelas de gold
CREATE INDEX ix_fato_vendas_data_key ON gold.fato_vendas(data_key);
CREATE INDEX ix_fato_vendas_cliente_key ON gold.fato_vendas(cliente_key);
CREATE INDEX ix_fato_vendas_produto_key ON gold.fato_vendas(produto_key);
CREATE INDEX ix_dim_tempo_data ON gold.dim_tempo(data_completa);

-- ==========================================
-- 8. CRIAÇÃO DE ALGUMAS VIEWS ÚTEIS
-- ==========================================

-- View para análise simples de vendas
CREATE VIEW silver.vw_vendas_detalhadas AS
SELECT 
    v.id as venda_id,
    c.nome as cliente_nome,
    c.cidade as cliente_cidade,
    p.nome as produto_nome,
    p.categoria as produto_categoria,
    v.quantidade,
    v.valor_unitario,
    v.valor_total,
    v.data_venda,
    v.canal_venda,
    DATEDIFF(YEAR, c.data_cadastro, v.data_venda) as tempo_cliente_anos
FROM bronze.vendas v
INNER JOIN bronze.clientes c ON v.cliente_id = c.id
INNER JOIN bronze.produtos p ON v.produto_id = p.id
WHERE c.ativo = 1;

-- View para métricas de produtos
CREATE VIEW silver.vw_metricas_produtos AS
SELECT 
    p.categoria,
    p.subcategoria,
    COUNT(v.id) as total_vendas,
    SUM(v.quantidade) as total_itens_vendidos,
    SUM(v.valor_total) as receita_total,
    AVG(v.valor_total) as ticket_medio,
    SUM(v.valor_total - (p.preco_custo * v.quantidade)) as lucro_total
FROM bronze.produtos p
LEFT JOIN bronze.vendas v ON p.id = v.produto_id
GROUP BY p.categoria, p.subcategoria;

-- ==========================================
-- 9. CRIAÇÃO DE STORED PROCEDURES BÁSICAS
-- ==========================================

-- Procedure para registrar logs de processamento
CREATE PROCEDURE util.usp_registrar_log
    @processo VARCHAR(100),
    @descricao VARCHAR(500) = NULL,
    @status VARCHAR(20) = 'SUCESSO',
    @linhas_processadas INT = NULL,
    @erro_mensagem VARCHAR(1000) = NULL
AS
BEGIN
    INSERT INTO util.processamento_logs (processo, descricao, status, linhas_processadas, data_inicio, data_fim, erro_mensagem)
    VALUES (@processo, @descricao, @status, @linhas_processadas, GETDATE(), GETDATE(), @erro_mensagem);
END;
GO

-- Procedure para popular dimensão clientes
CREATE PROCEDURE gold.usp_popular_dim_clientes
AS
BEGIN
    BEGIN TRY
        EXEC util.usp_registrar_log 'POPULAR_DIM_CLIENTES', 'Iniciando população da dimensão clientes', 'EXECUTANDO';
        
        INSERT INTO gold.dim_clientes (cliente_id, nome, email, idade, faixa_etaria, cidade, estado, data_cadastro, cliente_ativo)
        SELECT 
            id,
            nome,
            email,
            idade,
            CASE 
                WHEN idade < 20 THEN 'Menor 20'
                WHEN idade BETWEEN 20 AND 29 THEN '20-29'
                WHEN idade BETWEEN 30 AND 39 THEN '30-39'
                WHEN idade BETWEEN 40 AND 49 THEN '40-49'
                ELSE '50+'
            END as faixa_etaria,
            cidade,
            estado,
            data_cadastro,
            ativo
        FROM bronze.clientes;
        
        EXEC util.usp_registrar_log 'POPULAR_DIM_CLIENTES', 
            'População concluída com sucesso', 
            'SUCESSO', 
            @linhas_processadas = @@ROWCOUNT;
            
    END TRY
    BEGIN CATCH
        EXEC util.usp_registrar_log 'POPULAR_DIM_CLIENTES', 
            'Erro na população da dimensão', 
            'ERRO', 
            @erro_mensagem = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO

-- ==========================================
-- 10. EXECUÇÃO INICIAL DOS PROCESSOS
-- ==========================================

-- Popular dimensões iniciais
EXEC gold.usp_popular_dim_clientes;

-- Mensagem final
PRINT '==========================================';
PRINT '✅ BANCO DE DADOS CONFIGURADO COM SUCESSO!';
PRINT '==========================================';
PRINT '📊 Estrutura criada:';
PRINT '   • Bronze Layer: Dados brutos';
PRINT '   • Silver Layer: Views e dados processados';  
PRINT '   • Gold Layer: Modelo dimensional';
PRINT '   • Util: Procedures e logs';
PRINT '';
PRINT '🎯 Próximos passos:';
PRINT '   1. Testar as views e procedures';
PRINT '   2. Executar consultas de exemplo';
PRINT '   3. Iniciar desenvolvimento do roadmap';
PRINT '==========================================';