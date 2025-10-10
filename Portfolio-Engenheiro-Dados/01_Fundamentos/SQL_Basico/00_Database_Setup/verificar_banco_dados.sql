-- 🔍 SCRIPT DE VERIFICAÇÃO DO BANCO DE DADOS
-- Verifica se tudo foi criado corretamente

USE RoadmapEngenhariaDados;
GO

-- 1. Verificar tabelas criadas
SELECT 
    SCHEMA_NAME(schema_id) as schema_name,
    name as table_name,
    create_date
FROM sys.tables 
WHERE SCHEMA_NAME(schema_id) IN ('bronze', 'silver', 'gold', 'util')
ORDER BY schema_name, table_name;

-- 2. Verificar quantidade de registros
SELECT 
    'bronze.clientes' as tabela,
    COUNT(*) as registros
FROM bronze.clientes
UNION ALL
SELECT 
    'bronze.produtos',
    COUNT(*) 
FROM bronze.produtos
UNION ALL
SELECT 
    'bronze.vendas',
    COUNT(*) 
FROM bronze.vendas
UNION ALL
SELECT 
    'gold.dim_clientes',
    COUNT(*) 
FROM gold.dim_clientes
UNION ALL
SELECT 
    'gold.dim_tempo',
    COUNT(*) 
FROM gold.dim_tempo;

-- 3. Verificar views
SELECT 
    SCHEMA_NAME(schema_id) as schema_name,
    name as view_name
FROM sys.views 
ORDER BY schema_name, view_name;

-- 4. Verificar stored procedures
SELECT 
    SCHEMA_NAME(schema_id) as schema_name,
    name as procedure_name
FROM sys.procedures 
ORDER BY schema_name, procedure_name;

-- 5. Testar algumas consultas
PRINT '🎯 TESTANDO CONSULTAS BÁSICAS:';

-- Consulta na view de vendas
PRINT '📈 Vendas detalhadas:';
SELECT TOP 5 * FROM silver.vw_vendas_detalhadas;

-- Consulta na view de métricas
PRINT '📊 Métricas por categoria:';
SELECT * FROM silver.vw_metricas_produtos;

-- Testar procedure de log
PRINT '📝 Testando procedure de log:';
EXEC util.usp_registrar_log 'TESTE_VERIFICACAO', 'Script de verificação executado', 'SUCESSO';

-- Verificar logs
PRINT '📋 Últimos logs:';
SELECT TOP 3 processo, status, data_inicio 
FROM util.processamento_logs 
ORDER BY data_inicio DESC;

PRINT '';
PRINT '✅ VERIFICAÇÃO CONCLUÍDA!';
PRINT '   Se todas as consultas retornaram resultados, o banco está pronto para uso.';