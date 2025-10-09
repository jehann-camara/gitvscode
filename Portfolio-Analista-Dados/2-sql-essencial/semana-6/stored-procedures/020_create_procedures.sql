-- Script 020: Stored Procedures Básicas
-- Data: 2024-02-12
-- Descrição: Criar procedures para operações comuns

USE data_analytics_study;

-- Procedure para inserir novo cliente
DELIMITER //
CREATE PROCEDURE sp_InsertCustomer(
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_email VARCHAR(100)
)
BEGIN
    INSERT INTO customers (first_name, last_name, email)
    VALUES (p_first_name, p_last_name, p_email);
END //
DELIMITER ;

-- Procedure para obter vendas por período
DELIMITER //
CREATE PROCEDURE sp_GetSalesByPeriod(
    IN start_date DATE,
    IN end_date DATE
)
BEGIN
    SELECT 
        s.sale_id,
        c.first_name,
        c.last_name,
        p.product_name,
        s.sale_date,
        s.quantity,
        s.total_amount
    FROM sales s
    INNER JOIN customers c ON s.customer_id = c.customer_id
    INNER JOIN products p ON s.product_id = p.product_id
    WHERE s.sale_date BETWEEN start_date AND end_date
    ORDER BY s.sale_date DESC;
END //
DELIMITER ;

-- Procedure para atualizar estoque
DELIMITER //
CREATE PROCEDURE sp_UpdateStock(
    IN p_product_id INT,
    IN p_quantity_change INT
)
BEGIN
    UPDATE products 
    SET stock_quantity = stock_quantity + p_quantity_change
    WHERE product_id = p_product_id;
    
    SELECT 
        product_id,
        product_name,
        stock_quantity
    FROM products
    WHERE product_id = p_product_id;
END //
DELIMITER ;

-- Testando as procedures
CALL sp_InsertCustomer('Fernanda', 'Lima', 'fernanda.lima@email.com');
CALL sp_GetSalesByPeriod('2024-01-01', '2024-01-15');
CALL sp_UpdateStock(1, -2);  -- Reduzir estoque em 2 unidades