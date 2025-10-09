-- Script 023: Gerenciamento de Views
-- Data: 2024-02-15
-- Descrição: Criar e utilizar views para abstração

USE data_analytics_study;

-- View para resumo de vendas com informações completas
CREATE VIEW vw_SalesSummary AS
SELECT 
    s.sale_id,
    s.sale_date,
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    p.product_id,
    p.product_name,
    p.category,
    s.quantity,
    s.unit_price,
    s.total_amount,
    CASE 
        WHEN s.total_amount > 1000 THEN 'Alto Valor'
        WHEN s.total_amount > 500 THEN 'Médio Valor'
        ELSE 'Baixo Valor'
    END AS sale_category
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
INNER JOIN products p ON s.product_id = p.product_id;

-- View para análise de clientes
CREATE VIEW vw_CustomerAnalysis AS
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    c.email,
    c.created_date,
    COUNT(s.sale_id) AS total_purchases,
    COALESCE(SUM(s.total_amount), 0) AS total_spent,
    COALESCE(AVG(s.total_amount), 0) AS avg_purchase_value,
    MAX(s.sale_date) AS last_purchase_date,
    CASE 
        WHEN COUNT(s.sale_id) = 0 THEN 'Novo'
        WHEN DATEDIFF(CURDATE(), MAX(s.sale_date)) > 90 THEN 'Inativo'
        ELSE 'Ativo'
    END AS customer_status
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email, c.created_date;

-- View para estoque crítico
CREATE VIEW vw_CriticalStock AS
SELECT 
    product_id,
    product_name,
    category,
    price,
    stock_quantity,
    CASE 
        WHEN stock_quantity = 0 THEN 'ESGOTADO'
        WHEN stock_quantity < 5 THEN 'CRÍTICO'
        WHEN stock_quantity < 10 THEN 'ALERTA'
        ELSE 'NORMAL'
    END AS stock_status
FROM products
WHERE stock_quantity < 10 OR stock_quantity IS NULL;

-- View para performance de produtos
CREATE VIEW vw_ProductPerformance AS
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.price,
    COUNT(s.sale_id) AS total_sales,
    COALESCE(SUM(s.quantity), 0) AS total_units_sold,
    COALESCE(SUM(s.total_amount), 0) AS total_revenue,
    COALESCE(AVG(s.total_amount), 0) AS avg_sale_value
FROM products p
LEFT JOIN sales s ON p.product_id = s.product_id
GROUP BY p.product_id, p.product_name, p.category, p.price;

-- Utilizando as views
SELECT * FROM vw_SalesSummary WHERE sale_date >= '2024-01-01';

SELECT 
    customer_status,
    COUNT(*) AS total_customers,
    AVG(total_spent) AS avg_spent
FROM vw_CustomerAnalysis
GROUP BY customer_status;

SELECT * FROM vw_CriticalStock ORDER BY stock_quantity ASC;

SELECT 
    category,
    SUM(total_revenue) AS category_revenue,
    SUM(total_units_sold) AS total_units
FROM vw_ProductPerformance
GROUP BY category
ORDER BY category_revenue DESC;