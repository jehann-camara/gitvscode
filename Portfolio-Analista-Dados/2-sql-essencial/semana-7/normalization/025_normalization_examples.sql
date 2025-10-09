-- Script 025: Exemplos de Normalização
-- Data: 2024-02-20
-- Descrição: Demonstrar os passos de normalização

USE ecommerce_normalized;

-- Inserindo dados de exemplo para demonstração

-- 1. Inserir endereços
INSERT INTO addresses (street, city, state, zip_code) VALUES
('Rua das Flores, 123', 'São Paulo', 'SP', '01234-567'),
('Av. Brasil, 456', 'Rio de Janeiro', 'RJ', '22345-678'),
('Rua Augusta, 789', 'São Paulo', 'SP', '01345-679');

-- 2. Inserir status de pedidos
INSERT INTO order_status (status_name, description) VALUES
('pending', 'Pedido realizado, aguardando pagamento'),
('confirmed', 'Pagamento confirmado, processando pedido'),
('shipped', 'Pedido enviado para transporte'),
('delivered', 'Pedido entregue ao cliente'),
('cancelled', 'Pedido cancelado');

-- 3. Inserir categorias
INSERT INTO categories (category_name, description, parent_category_id) VALUES
('Eletrônicos', 'Dispositivos eletrônicos em geral', NULL),
('Computadores', 'Computadores e acessórios', 1),
('Smartphones', 'Telefones celulares e tablets', 1),
('Periféricos', 'Mouse, teclado, monitor', 2);

-- 4. Inserir fornecedores
INSERT INTO suppliers (company_name, contact_name, email, phone, address_id) VALUES
('TechSupply Brasil', 'Carlos Mendes', 'vendas@techsupply.com.br', '(11) 3333-4444', 1),
('EletroParts', 'Ana Silva', 'contato@eletroparts.com', '(21) 5555-6666', 2);

-- 5. Inserir produtos
INSERT INTO products (product_name, description, sku, price, cost_price, category_id, supplier_id, weight_kg) VALUES
('Notebook Dell i7', 'Notebook Dell com processador i7, 16GB RAM, SSD 512GB', 'DELL-I7-16GB', 3500.00, 2800.00, 2, 1, 2.1),
('iPhone 15 128GB', 'Apple iPhone 15 128GB, tela 6.1", 5G', 'IPHONE15-128', 5000.00, 4200.00, 3, 1, 0.171),
('Mouse Logitech MX', 'Mouse sem fio Logitech MX Master 3', 'LOG-MX-MASTER3', 299.90, 180.00, 4, 2, 0.141),
('Monitor Samsung 24"', 'Monitor Samsung 24" Full HD, 75Hz', 'SAM-MON-24FHD', 899.00, 650.00, 4, 2, 3.2);

-- 6. Inserir estoque
INSERT INTO inventory (product_id, quantity, reorder_level, location) VALUES
(1, 15, 3, 'Prateleira A1'),
(2, 8, 2, 'Prateleira B2'),
(3, 25, 10, 'Prateleira C1'),
(4, 12, 5, 'Prateleira A3');

-- 7. Inserir clientes
INSERT INTO customers (first_name, last_name, email, phone, address_id, date_of_birth) VALUES
('João', 'Silva', 'joao.silva@email.com', '(11) 99999-9999', 1, '1985-03-15'),
('Maria', 'Santos', 'maria.santos@email.com', '(21) 88888-8888', 2, '1990-07-22'),
('Pedro', 'Oliveira', 'pedro.oliveira@email.com', '(11) 77777-7777', 3, '1988-11-30');

-- 8. Inserir pedidos
INSERT INTO orders (customer_id, status_id, total_amount, shipping_address_id, billing_address_id, shipping_cost) VALUES
(1, 2, 3799.90, 1, 1, 25.00),
(2, 3, 5000.00, 2, 2, 35.00),
(1, 4, 1198.90, 1, 1, 15.00);

-- 9. Inserir itens dos pedidos
INSERT INTO order_items (order_id, product_id, quantity, unit_price, total_price) VALUES
(1, 3, 1, 299.90, 299.90),  -- Mouse
(1, 4, 1, 899.00, 899.00),  -- Monitor
(2, 2, 1, 5000.00, 5000.00), -- iPhone
(3, 3, 2, 299.90, 599.80),  -- 2 Mouses
(3, 1, 1, 3500.00, 3500.00); -- Notebook

-- 10. Atualizar totais dos pedidos baseado nos itens
UPDATE orders o
SET total_amount = (
    SELECT COALESCE(SUM(total_price), 0) 
    FROM order_items oi 
    WHERE oi.order_id = o.order_id
) + shipping_cost;

-- Consultas demonstrando a normalização

-- Consulta complexa usando múltiplas junções
SELECT 
    o.order_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    os.status_name AS order_status,
    o.order_date,
    o.total_amount,
    COUNT(oi.order_item_id) AS total_items,
    GROUP_CONCAT(p.product_name SEPARATOR ', ') AS products
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN order_status os ON o.status_id = os.status_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id
GROUP BY o.order_id, c.first_name, c.last_name, os.status_name, o.order_date, o.total_amount
ORDER BY o.order_date DESC;