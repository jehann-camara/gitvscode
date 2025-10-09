-- Script 029: Procedures de Manutenção
-- Data: 2024-02-28
-- Descrição: Procedures para manutenção do banco

USE ecommerce_normalized;

-- 1. PROCEDURE PARA LIMPEZA DE DADOS ANTIGOS
DELIMITER //
CREATE PROCEDURE sp_CleanupOldData(
    IN p_cutoff_date DATE,
    IN p_max_rows INT,
    OUT p_deleted_count INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
    START TRANSACTION;
    
    -- Deletar pedidos cancelados antigos
    DELETE FROM orders 
    WHERE order_date < p_cutoff_date 
        AND status_id = 5  -- status cancelled
    LIMIT p_max_rows;
    
    SET p_deleted_count = ROW_COUNT();
    
    COMMIT;
END //
DELIMITER ;

-- 2. PROCEDURE PARA REABASTECIMENTO DE ESTOQUE
DELIMITER //
CREATE PROCEDURE sp_RestockInventory(
    IN p_product_id INT,
    IN p_quantity INT,
    IN p_supplier_id INT
)
BEGIN
    DECLARE current_quantity INT;
    DECLARE product_exists INT DEFAULT 0;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
    START TRANSACTION;
    
    -- Verificar se produto existe
    SELECT COUNT(*) INTO product_exists
    FROM products
    WHERE product_id = p_product_id AND supplier_id = p_supplier_id;
    
    IF product_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Produto não encontrado ou fornecedor incorreto';
    END IF;
    
    -- Obter quantidade atual com lock
    SELECT quantity INTO current_quantity
    FROM inventory
    WHERE product_id = p_product_id
    FOR UPDATE;
    
    IF current_quantity IS NOT NULL THEN
        -- Atualizar estoque existente
        UPDATE inventory 
        SET quantity = quantity + p_quantity,
            last_restock_date = CURRENT_DATE,
            updated_at = CURRENT_TIMESTAMP
        WHERE product_id = p_product_id;
    ELSE
        -- Inserir novo registro de estoque
        INSERT INTO inventory (product_id, quantity, last_restock_date, location)
        VALUES (p_product_id, p_quantity, CURRENT_DATE, 'Recebimento');
    END IF;
    
    COMMIT;
    
    -- Retornar novo status do estoque
    SELECT 
        p.product_name,
        i.quantity AS novo_estoque,
        i.last_restock_date
    FROM inventory i
    INNER JOIN products p ON i.product_id = p.product_id
    WHERE i.product_id = p_product_id;
    
END //
DELIMITER ;

-- 3. PROCEDURE PARA RELATÓRIO DE PERFORMANCE
DELIMITER //
CREATE PROCEDURE sp_GeneratePerformanceReport(
    IN start_date DATE,
    IN end_date DATE
)
BEGIN
    -- Métricas de vendas
    SELECT 
        'sales_metrics' AS report_section,
        COUNT(*) AS total_orders,
        COUNT(DISTINCT customer_id) AS unique_customers,
        SUM(total_amount) AS total_revenue,
        AVG(total_amount) AS avg_order_value,
        MAX(total_amount) AS max_order_value
    FROM orders
    WHERE order_date BETWEEN start_date AND end_date
        AND status_id IN (2,3,4);
    
    -- Métricas de produtos (top 10)
    SELECT 
        'product_metrics' AS report_section,
        p.product_name,
        c.category_name,
        SUM(oi.quantity) AS units_sold,
        SUM(oi.total_price) AS revenue,
        COUNT(DISTINCT oi.order_id) AS order_count,
        AVG(oi.unit_price) AS avg_unit_price
    FROM products p
    INNER JOIN categories c ON p.category_id = c.category_id
    INNER JOIN order_items oi ON p.product_id = oi.product_id
    INNER JOIN orders o ON oi.order_id = o.order_id
    WHERE o.order_date BETWEEN start_date AND end_date
        AND o.status_id IN (2,3,4)
    GROUP BY p.product_id, p.product_name, c.category_name
    ORDER BY revenue DESC
    LIMIT 10;
    
    -- Métricas de clientes (top 10)
    SELECT 
        'customer_metrics' AS report_section,
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        COUNT(o.order_id) AS order_count,
        SUM(o.total_amount) AS total_spent,
        MAX(o.order_date) AS last_order_date
    FROM customers c
    INNER JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.order_date BETWEEN start_date AND end_date
        AND o.status_id IN (2,3,4)
    GROUP BY c.customer_id, c.first_name, c.last_name
    ORDER BY total_spent DESC
    LIMIT 10;
    
    -- Métricas de estoque
    SELECT 
        'inventory_metrics' AS report_section,
        COUNT(*) AS total_products,
        SUM(quantity) AS total_units,
        SUM(CASE WHEN quantity = 0 THEN 1 ELSE 0 END) AS out_of_stock,
        SUM(CASE WHEN quantity <= reorder_level THEN 1 ELSE 0 END) AS need_reorder,
        AVG(quantity) AS avg_stock_level
    FROM inventory;
    
END //
DELIMITER ;

-- 4. PROCEDURE PARA BACKUP DE DADOS IMPORTANTES
DELIMITER //
CREATE PROCEDURE sp_CreateDataBackup()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
    START TRANSACTION;
    
    -- Criar tabela de backup de pedidos (se não existir)
    CREATE TABLE IF NOT EXISTS orders_backup (
        backup_id INT PRIMARY KEY AUTO_INCREMENT,
        backup_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        order_id INT,
        customer_id INT,
        order_date TIMESTAMP,
        total_amount DECIMAL(10,2),
        status_id INT,
        KEY idx_backup_date (backup_date),
        KEY idx_order_id (order_id)
    ) ENGINE=InnoDB;
    
    -- Inserir backup dos últimos 30 dias
    INSERT INTO orders_backup (order_id, customer_id, order_date, total_amount, status_id)
    SELECT order_id, customer_id, order_date, total_amount, status_id
    FROM orders
    WHERE order_date >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY);
    
    -- Criar/atualizar tabela de backup de produtos
    CREATE TABLE IF NOT EXISTS products_backup (
        backup_id INT PRIMARY KEY AUTO_INCREMENT,
        backup_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        product_id INT,
        product_name VARCHAR(100),
        price DECIMAL(10,2),
        cost_price DECIMAL(10,2),
        is_active BOOLEAN,
        KEY idx_backup_date (backup_date)
    ) ENGINE=InnoDB;
    
    -- Backup de produtos ativos
    INSERT INTO products_backup (product_id, product_name, price, cost_price, is_active)
    SELECT product_id, product_name, price, cost_price, is_active
    FROM products
    WHERE is_active = TRUE;
    
    COMMIT;
    
    SELECT 
        'Backup completed' AS result,
        COUNT(*) AS orders_backed_up,
        (SELECT COUNT(*) FROM products_backup WHERE backup_date = CURRENT_DATE) AS products_backed_up
    FROM orders_backup 
    WHERE backup_date = CURRENT_DATE;
    
END //
DELIMITER ;

-- 5. PROCEDURE PARA OTIMIZAÇÃO DE TABELAS
DELIMITER //
CREATE PROCEDURE sp_OptimizeTables()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE table_name VARCHAR(64);
    DECLARE table_cursor CURSOR FOR 
        SELECT TABLE_NAME 
        FROM INFORMATION_SCHEMA.TABLES 
        WHERE TABLE_SCHEMA = 'ecommerce_normalized' 
        AND TABLE_TYPE = 'BASE TABLE';
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN table_cursor;
    
    read_loop: LOOP
        FETCH table_cursor INTO table_name;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Executar OPTIMIZE TABLE para cada tabela
        SET @sql = CONCAT('OPTIMIZE TABLE `', table_name, '`');
        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END LOOP;
    
    CLOSE table_cursor;
    
    SELECT 'Table optimization completed' AS result;
    
END //
DELIMITER ;

-- Testando as procedures
CALL sp_CleanupOldData('2023-12-01', 100, @deleted_count);
SELECT @deleted_count;

CALL sp_RestockInventory(1, 50, 1);

CALL sp_GeneratePerformanceReport('2024-01-01', '2024-02-28');

CALL sp_CreateDataBackup();

-- CALL sp_OptimizeTables();  -- Executar com cuidado em produção