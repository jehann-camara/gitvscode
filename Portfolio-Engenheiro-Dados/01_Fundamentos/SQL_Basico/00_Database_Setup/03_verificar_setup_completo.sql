-- 🗃️ [03] VERIFICAÇÃO COMPLETA DO SETUP
-- TERCEIRO script a ser executado - Verifica se tudo foi criado corretamente

PRINT '==========================================';
PRINT '🔍 INICIANDO VERIFICAÇÃO COMPLETA (03/03)';
PRINT '==========================================';

USE MASTER;
GO
-- 1. VERIFICAR ESTUDOS_SQL
PRINT '1. VERIFICANDO DATABASE estudos_sql...';
USE estudos_sql;
GO

PRINT '   📊 Contagem de registros:';
SELECT 
    'clientes' as tabela,
    COUNT(*) as registros
FROM clientes
UNION ALL
SELECT 
    'produtos',
    COUNT(*) 
FROM produtos
UNION ALL
SELECT 
    'pedidos',
    COUNT(*) 
FROM pedidos;
GO

PRINT '   ✅ estudos_sql verificado com sucesso!';
GO

-- 2. VERIFICAR ROADMAPENGENHARIADADOS
PRINT '';
PRINT '2. VERIFICANDO DATABASE RoadmapEngenhariaDados...';
USE RoadmapEngenhariaDados;
GO

PRINT '   📊 Estrutura criada:';
SELECT 
    SCHEMA_NAME(schema_id) as schema_name,
    name as object_name,
    type_desc as object_type
FROM sys.objects 
WHERE type IN ('U', 'V', 'P')
ORDER BY schema_name, type_desc, object_name;
GO

PRINT '   📊 Contagem de registros bronze layer:';
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
FROM bronze.vendas;
GO

-- 3. TESTAR PROCEDURES E VIEWS
PRINT '';
PRINT '3. TESTANDO FUNCIONALIDADES...';

PRINT '   🧪 Testando view silver.vw_vendas_detalhadas:';
SELECT TOP 2 * FROM silver.vw_vendas_detalhadas;
GO

PRINT '   🧪 Testando procedure util.usp_registrar_log:';
EXEC util.usp_registrar_log 'VERIFICACAO_SETUP', 'Teste de verificação completo', 'SUCESSO';
GO

PRINT '   📋 Logs gerados:';
SELECT TOP 3 processo, status, data_inicio 
FROM util.processamento_logs 
ORDER BY data_inicio DESC;
GO

-- 4. RELATÓRIO FINAL
PRINT '';
PRINT '==========================================';
PRINT '✅ VERIFICAÇÃO CONCLUÍDA COM SUCESSO! (03/03)';
PRINT '==========================================';
PRINT '🎉 AMBIENTE COMPLETAMENTE CONFIGURADO!';
PRINT '';
PRINT '📚 DATABASES CRIADOS:';
PRINT '   1. estudos_sql - Para exercícios do Mês 1';
PRINT '   2. RoadmapEngenhariaDados - Para projetos Meses 2-7';
PRINT '';
PRINT '🚀 PRÓXIMOS PASSOS:';
PRINT '   1. Mês 1: USE estudos_sql para exercícios SQL básicos';
PRINT '   2. Mês 2: USE RoadmapEngenhariaDados para Python + SQL Server';
PRINT '   3. Consulte a documentação em ORDEM_EXECUCAO.md';
PRINT '';
PRINT '💡 DICA: Execute este script sempre que quiser verificar o ambiente.';
PRINT '==========================================';
GO