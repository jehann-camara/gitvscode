
-- Script 001: Criação do Database de Prática
-- Data: 2024-01-08
-- Descrição: Cria database inicial para estudos

DROP DATABASE IF EXISTS data_analytics_study;
CREATE DATABASE data_analytics_study;
USE data_analytics_study;

-- Criação da tabela de clientes
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    created_date DATE DEFAULT CURRENT_DATE,
    active BOOLEAN DEFAULT TRUE
);