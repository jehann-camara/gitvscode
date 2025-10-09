-- Script 026: Demonstração de Relacionamentos
-- Data: 2024-02-21
-- Descrição: Consultas com diferentes tipos de relacionamento

USE ecommerce_normalized;

-- 1. RELACIONAMENTO 1:1 (Customers - Addresses para faturamento)
-- Um cliente tem um endereço de faturamento principal
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    a.street,
    a.city,
    a.state,
    a.zip_code
FROM customers c
INNER JOIN addresses a ON c.address_id = a.address_id;

-- 2. RELACIONAMENTO 1:N (Customers - Orders)
-- Um cliente pode ter vários pedidos
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS total_spent,
    MAX(o.order_date) AS last_order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;

-- 3. RELACIONAMENTO N:N (Orders - Products através de Order_Items)
-- Um pedido pode ter vários produtos, um produto pode estar em vários pedidos
SELECT 
    o.order_id,
    o.order_date,
    COUNT(oi.product_id) AS total_products,
    SUM(oi.quantity) AS total_items,
    SUM(oi.total_price) AS order_total
FROM orders o
INNER JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id, o.order_date
ORDER BY o.order_date DESC;

-- 4. RELACIONAMENTO HIERÁRQUICO (Categories - parent_category_id)
-- Categorias podem ter subcategorias (relacionamento recursivo)
SELECT 
    child.category_id,
    child.category_name AS child_category,
    parent.category_name AS parent_category
FROM categories child
LEFT JOIN categories parent ON child.parent_category_id = parent.category_id
ORDER BY parent.category_name, child.category_name;

-- 5. RELACIONAMENTO COM ATRIBUTOS (Product_Reviews)
-- Relacionamento entre Customers e Products com atributos adicionais (rating, review_text)
SELECT 
    pr.review_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    p.product_name,
    pr.rating,
    pr.review_text,
    pr.created_at
FROM product_reviews pr
INNER JOIN customers c ON pr.customer_id = c.customer_id
INNER JOIN products p ON pr.product_id = p.product_id
WHERE pr.is_approved = TRUE
ORDER BY pr.rating DESC, pr.created_at DESC;

-- 6. CONSULTA COMPLEXA: Análise de fornecedores com múltiplos relacionamentos
SELECT 
    s.supplier_id,
    s.company_name,
    COUNT(p.product_id) AS total_products,
    SUM(i.quantity) AS total_stock,
    COALESCE(SUM(oi.quantity), 0) AS total_sold,
    COALESCE(SUM(oi.total_price), 0) AS total_revenue
FROM suppliers s
LEFT JOIN products p ON s.supplier_id = p.supplier_id
LEFT JOIN inventory i ON p.product_id = i.product_id
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY s.supplier_id, s.company_name
ORDER BY total_revenue DESC;

-- 7. RELACIONAMENTO DE AGREGAÇÃO: Pedidos com múltiplos endereços
SELECT 
    o.order_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    shipping.street AS shipping_address,
    billing.street AS billing_address,
    CASE 
        WHEN shipping.address_id = billing.address_id THEN 'Mesmo endereço'
        ELSE 'Endereços diferentes'
    END AS address_type
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN addresses shipping ON o.shipping_address_id = shipping.address_id
INNER JOIN addresses billing ON o.billing_address_id = billing.address_id;

-- 8. CONSULTA COM SUBQUERY CORRELACIONADA: Produtos com estoque abaixo do nível de reposição
SELECT 
    p.product_name,
    p.sku,
    i.quantity,
    i.reorder_level,
    (SELECT COUNT(*) FROM order_items oi WHERE oi.product_id = p.product_id) AS times_ordered
FROM products p
INNER JOIN inventory i ON p.product_id = i.product_id
WHERE i.quantity <= i.reorder_level
ORDER BY i.quantity ASC;