-- Script 028: Otimização de Performance
-- Data: 2024-02-27
-- Descrição: Índices, análise de queries e otimização

USE ecommerce_normalized;

-- 1. CRIAR ÍNDICES ESTRATÉGICOS
-- Índices para consultas frequentes
CREATE INDEX idx_orders_customer_date ON orders(customer_id, order_date);
CREATE INDEX idx_orders_status_date ON orders(status_id, order_date);
CREATE INDEX idx_order_items_order_product ON order_items(order_id, product_id);
CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_products_supplier ON products(supplier_id);
CREATE INDEX idx_customers_email ON customers(email);
CREATE INDEX idx_inventory_product ON inventory(product_id);

-- Índices compostos para consultas analíticas
CREATE INDEX idx_sales_analysis ON orders(customer_id, status_id, order_date, total_amount);
CREATE INDEX idx_product_analysis ON order_items(product_id, quantity, unit_price);

-- 2. ANALISAR PERFORMANCE DE QUERIES COM EXPLAIN
-- Query 1: Análise de clientes
EXPLAIN FORMAT=JSON
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= '2024-01-01'
    AND o.status_id IN (2,3,4)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING total_spent > 1000;

-- Query 2: Análise de produtos
EXPLAIN FORMAT=JSON
SELECT 
    p.product_name,
    c.category_name,
    SUM(oi.quantity) AS total_vendido,
    SUM(oi.total_price) AS receita_total
FROM products p
INNER JOIN categories c ON p.category_id = c.category_id
INNER JOIN order_items oi ON p.product_id = oi.product_id
INNER JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_date BETWEEN '2024-01-01' AND '2024-02-28'
    AND o.status_id IN (2,3,4)
GROUP BY p.product_id, p.product_name, c.category_name
ORDER BY receita_total DESC;

-- 3. QUERIES OTIMIZADAS
-- Versão otimizada usando covering indexes
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    o.order_count,
    o.total_spent
FROM customers c
INNER JOIN (
    SELECT 
        customer_id,
        COUNT(*) AS order_count,
        SUM(total_amount) AS total_spent
    FROM orders
    WHERE order_date >= '2024-01-01'
        AND status_id IN (2,3,4)
    GROUP BY customer_id
    HAVING SUM(total_amount) > 1000
) o ON c.customer_id = o.customer_id;

-- 4. ANÁLISE DE USO DE ÍNDICES
-- Consultar estatísticas de uso de índices
SELECT 
    TABLE_NAME,
    INDEX_NAME,
    SEQ_IN_INDEX,
    COLUMN_NAME,
    CARDINALITY,
    INDEX_TYPE
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_SCHEMA = 'ecommerce_normalized'
    AND TABLE_NAME IN ('orders', 'customers', 'products', 'order_items')
ORDER BY TABLE_NAME, INDEX_NAME, SEQ_IN_INDEX;

-- 5. IDENTIFICAR QUERIES LENTAS (simulação)
-- Em produção, usar performance_schema ou slow query log
SELECT 
    'orders_customer_date' AS index_name,
    COUNT(*) AS usage_count
FROM orders 
WHERE customer_id IS NOT NULL AND order_date IS NOT NULL
UNION ALL
SELECT 
    'products_category' AS index_name,
    COUNT(*) AS usage_count
FROM products 
WHERE category_id IS NOT NULL;

-- 6. MANUTENÇÃO DE ÍNDICES
-- Atualizar estatísticas
ANALYZE TABLE customers, orders, products, order_items;

-- Verificar fragmentação de índices
SELECT 
    TABLE_NAME,
    INDEX_NAME,
    ROUND(stat_value * @@innodb_page_size / 1024 / 1024, 2) AS size_mb
FROM mysql.innodb_index_stats
WHERE database_name = 'ecommerce_normalized'
    AND stat_name = 'size'
ORDER BY size_mb DESC;

-- 7. CONSULTA COM PLANO DE EXECUÇÃO MELHORADO
-- Usando CTEs e índices apropriados
WITH recent_orders AS (
    SELECT 
        customer_id,
        order_id,
        total_amount
    FROM orders
    WHERE order_date >= '2024-01-01'
        AND status_id IN (2,3,4)
    ORDER BY order_date DESC
),
customer_summary AS (
    SELECT 
        customer_id,
        COUNT(*) AS order_count,
        SUM(total_amount) AS total_spent
    FROM recent_orders
    GROUP BY customer_id
    HAVING total_spent > 1000
)
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    cs.order_count,
    cs.total_spent
FROM customers c
INNER JOIN customer_summary cs ON c.customer_id = cs.customer_id
ORDER BY cs.total_spent DESC;