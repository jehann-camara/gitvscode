-- Script 002: Criação da Tabela de Produtos
-- Data: 2024-01-08
-- Descrição: Cria tabela de produtos para exercícios

USE data_analytics_study;

DROP TABLE IF EXISTS products;

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock_quantity INT,
    created_at DATE DEFAULT CURRENT_DATE
);