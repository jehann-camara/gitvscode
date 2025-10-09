
-- Agrupar e calcular totais // By Jehann Câmara

USE TechStore;

SELECT categoria_id, COUNT(*) as total_produtos
FROM produtos
GROUP BY categoria_id;