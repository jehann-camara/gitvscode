-- Script 012: Setup do Projeto E-commerce
-- Data: 2024-01-22
-- Descrição: Criação da estrutura completa para o projeto

USE data_analytics_study;

-- Tabela de categorias
DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL,
    description TEXT
);

-- Inserir categorias
INSERT INTO categories (category_name, description) VALUES
('Eletrônicos', 'Dispositivos eletrônicos e tecnologia'),
('Acessórios', 'Acessórios para computador e periféricos'),
('Software', 'Programas e licenças de software'),
('Móveis', 'Móveis para escritório');

-- Atualizar produtos com category_id
ALTER TABLE products ADD COLUMN category_id INT;
UPDATE products SET category_id = 1 WHERE category = 'Eletrônicos';
UPDATE products SET category_id = 2 WHERE category = 'Acessórios';

-- Adicionar foreign key
ALTER TABLE products 
ADD FOREIGN KEY (category_id) REFERENCES categories(category_id);