
-- Análise de Clientes - TechStore // By Jehann Câmara
-- Este arquivo contém consultas para análise do perfil e comportamento dos clientes.

USE TechStore;

-- 1.1 Total de clientes por cidade
SELECT 
    cidade,
    COUNT(*) as total_clientes
FROM clientes
GROUP BY cidade
ORDER BY total_clientes DESC;

-- 1.2 Clientes cadastrados nos últimos 30 dias
SELECT 
    nome,
    email,
    cidade,
    data_cadastro
FROM clientes
WHERE data_cadastro >= DATEADD(day, -30, GETDATE())
ORDER BY data_cadastro DESC;

-- 1.3 Clientes que mais compram (valor total)
SELECT 
    c.nome as cliente,
    SUM(p.total) as total_gasto,
    COUNT(p.id) as total_pedidos
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id
WHERE p.status != 'Cancelado'
GROUP BY c.nome
ORDER BY total_gasto DESC;