-- Script 003: Inserção de Dados de Exemplo
-- Data: 2024-01-09
-- Descrição: Popula tabelas com dados para prática

USE data_analytics_study;

-- Inserindo clientes
INSERT INTO customers (first_name, last_name, email) VALUES
('João', 'Silva', 'joao.silva@email.com'),
('Maria', 'Santos', 'maria.santos@email.com'),
('Pedro', 'Oliveira', 'pedro.oliveira@email.com'),
('Ana', 'Costa', 'ana.costa@email.com'),
('Carlos', 'Ferreira', 'carlos.ferreira@email.com');

-- Inserindo produtos
INSERT INTO products (product_name, category, price, stock_quantity) VALUES
('Notebook Dell', 'Eletrônicos', 2500.00, 10),
('Mouse Wireless', 'Acessórios', 89.90, 25),
('Teclado Mecânico', 'Acessórios', 199.99, 15),
('Monitor 24"', 'Eletrônicos', 899.00, 8),
('Webcam HD', 'Acessórios', 159.90, 12);