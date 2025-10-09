-- Script 018: CTEs Recursivas
-- Data: 2024-02-08
-- Descrição: CTEs para hierarquias e sequências

USE data_analytics_study;

-- Criar tabela de hierarquia organizacional
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    manager_id INT,
    salary DECIMAL(10,2)
);

INSERT INTO employees (first_name, last_name, manager_id, salary) VALUES
('Carlos', 'Silva', NULL, 10000.00),
('Ana', 'Ferreira', 1, 8000.00),
('Pedro', 'Santos', 1, 7500.00),
('Mariana', 'Costa', 2, 6000.00),
('João', 'Oliveira', 2, 5500.00),
('Carla', 'Ribeiro', 3, 5000.00);

-- CTE recursiva para hierarquia de funcionários
WITH RECURSIVE employee_hierarchy AS (
    -- Âncora: CEO (sem gerente)
    SELECT 
        employee_id,
        first_name,
        last_name,
        manager_id,
        0 AS level,
        CAST(CONCAT(first_name, ' ', last_name) AS CHAR(500)) AS hierarchy_path
    FROM employees
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Recursão: Funcionários com gerente
    SELECT 
        e.employee_id,
        e.first_name,
        e.last_name,
        e.manager_id,
        eh.level + 1,
        CAST(CONCAT(eh.hierarchy_path, ' -> ', e.first_name, ' ', e.last_name) AS CHAR(500))
    FROM employees e
    INNER JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
)
SELECT 
    employee_id,
    first_name,
    last_name,
    level,
    hierarchy_path
FROM employee_hierarchy
ORDER BY level, first_name;

-- CTE para gerar série temporal (últimos 7 dias)
WITH RECURSIVE date_series AS (
    SELECT CURDATE() - INTERVAL 6 DAY AS series_date
    UNION ALL
    SELECT series_date + INTERVAL 1 DAY
    FROM date_series
    WHERE series_date < CURDATE()
)
SELECT series_date
FROM date_series;