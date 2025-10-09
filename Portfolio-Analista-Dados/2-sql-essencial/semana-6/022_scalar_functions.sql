-- Script 022: User-Defined Functions Escalares
-- Data: 2024-02-14
-- Descrição: Criar funções que retornam valores únicos

USE data_analytics_study;

-- Função para calcular idade baseada na data de criação
DELIMITER //
CREATE FUNCTION fn_CalculateCustomerAge(customer_created_date DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, customer_created_date, CURDATE());
END //
DELIMITER ;

-- Função para formatar nome completo
DELIMITER //
CREATE FUNCTION fn_FullName(first_name VARCHAR(50), last_name VARCHAR(50))
RETURNS VARCHAR(101)
DETERMINISTIC
BEGIN
    RETURN CONCAT(first_name, ' ', last_name);
END //
DELIMITER ;

-- Função para classificar valor da venda
DELIMITER //
CREATE FUNCTION fn_ClassifySaleAmount(amount DECIMAL(10,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    RETURN CASE 
        WHEN amount > 1000 THEN 'Alto Valor'
        WHEN amount > 500 THEN 'Médio Valor'
        WHEN amount > 100 THEN 'Baixo Valor'
        ELSE 'Muito Baixo'
    END;
END //
DELIMITER ;

-- Função para calcular imposto
DELIMITER //
CREATE FUNCTION fn_CalculateTax(amount DECIMAL(10,2), tax_rate DECIMAL(5,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN amount * (tax_rate / 100);
END //
DELIMITER ;

-- Usando as funções em consultas
SELECT 
    customer_id,
    fn_FullName(first_name, last_name) AS nome_completo,
    created_date,
    fn_CalculateCustomerAge(created_date) AS anos_cadastro
FROM customers;

SELECT 
    sale_id,
    total_amount,
    fn_CalculateTax(total_amount, 10) AS imposto,
    fn_ClassifySaleAmount(total_amount) AS classificacao
FROM sales;