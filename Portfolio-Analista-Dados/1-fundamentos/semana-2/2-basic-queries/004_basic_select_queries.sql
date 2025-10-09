-- Script 004: Consultas SELECT Básicas
-- Data: 2024-01-09
-- Descrição: Primeiras queries de seleção

USE data_analytics_study;

-- Selecionar todos os clientes
SELECT * FROM customers;

-- Selecionar colunas específicas
SELECT first_name, last_name, email 
FROM customers;

-- Selecionar com alias (apelidos)
SELECT 
    first_name AS nome,
    last_name AS sobrenome,
    email AS email_contato
FROM customers;