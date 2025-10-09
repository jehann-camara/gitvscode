-- Script 021: Procedures com Parâmetros de Saída e Controle de Fluxo
-- Data: 2024-02-13
-- Descrição: Procedures avançadas com lógica condicional

USE data_analytics_study;

-- Procedure com parâmetro de saída: Total de vendas por cliente
DELIMITER //
CREATE PROCEDURE sp_GetCustomerSalesTotal(
    IN p_customer_id INT,
    OUT p_total_sales DECIMAL(10,2),
    OUT p_total_orders INT
)
BEGIN
    SELECT 
        COALESCE(SUM(total_amount), 0),
        COALESCE(COUNT(*), 0)
    INTO p_total_sales, p_total_orders
    FROM sales
    WHERE customer_id = p_customer_id;
END //
DELIMITER ;

-- Procedure com lógica condicional: Classificação de cliente
DELIMITER //
CREATE PROCEDURE sp_ClassifyCustomer(
    IN p_customer_id INT,
    OUT p_classification VARCHAR(20)
)
BEGIN
    DECLARE total_gasto DECIMAL(10,2);
    DECLARE total_pedidos INT;
    
    -- Obter métricas do cliente
    CALL sp_GetCustomerSalesTotal(p_customer_id, total_gasto, total_pedidos);
    
    -- Classificar baseado no total gasto e número de pedidos
    IF total_gasto > 1000 THEN
        SET p_classification = 'Premium';
    ELSEIF total_gasto > 500 AND total_pedidos > 1 THEN
        SET p_classification = 'Gold';
    ELSEIF total_gasto > 0 THEN
        SET p_classification = 'Silver';
    ELSE
        SET p_classification = 'Novo';
    END IF;
END //
DELIMITER ;

-- Procedure com tratamento de erro e transação
DELIMITER //
CREATE PROCEDURE sp_ProcessSale(
    IN p_customer_id INT,
    IN p_product_id INT,
    IN p_quantity INT
)
BEGIN
    DECLARE v_price DECIMAL(10,2);
    DECLARE v_stock INT;
    DECLARE v_total DECIMAL(10,2);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
    START TRANSACTION;
    
    -- Obter preço e verificar estoque
    SELECT price, stock_quantity INTO v_price, v_stock
    FROM products 
    WHERE product_id = p_product_id;
    
    IF v_stock < p_quantity THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Estoque insuficiente';
    END IF;
    
    -- Calcular total
    SET v_total = v_price * p_quantity;
    
    -- Inserir venda
    INSERT INTO sales (customer_id, product_id, sale_date, quantity, unit_price, total_amount)
    VALUES (p_customer_id, p_product_id, CURDATE(), p_quantity, v_price, v_total);
    
    -- Atualizar estoque
    UPDATE products 
    SET stock_quantity = stock_quantity - p_quantity
    WHERE product_id = p_product_id;
    
    COMMIT;
    
    SELECT 
        s.sale_id,
        c.first_name,
        c.last_name,
        p.product_name,
        s.quantity,
        s.total_amount
    FROM sales s
    INNER JOIN customers c ON s.customer_id = c.customer_id
    INNER JOIN products p ON s.product_id = p.product_id
    WHERE s.sale_id = LAST_INSERT_ID();
    
END //
DELIMITER ;

-- Testando procedures avançadas
CALL sp_GetCustomerSalesTotal(1, @total_sales, @total_orders);
SELECT @total_sales, @total_orders;

CALL sp_ClassifyCustomer(1, @classification);
SELECT @classification;

CALL sp_ProcessSale(1, 2, 1);