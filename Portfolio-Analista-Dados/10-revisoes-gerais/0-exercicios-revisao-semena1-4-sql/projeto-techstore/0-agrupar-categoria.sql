
-- Agrupar e calcular totais // By Jehann C�mara

USE TechStore;

SELECT categoria_id, COUNT(*) as total_produtos
FROM produtos
GROUP BY categoria_id;