# 🗃️ SETUP DO BANCO DE DADOS - ROADMAP ENGENHARIA DE DADOS

## 📋 OBJETIVO
Este diretório contém os scripts para criar e configurar todo o ambiente de banco de dados que será utilizado ao longo dos 7 meses do roadmap.

## 🚀 COMO USAR

### 1. EXECUTAR SETUP PRINCIPAL
```sql
-- Conectar ao SQL Server e executar:
-- Script para recriar o banco rapidamente
USE master;
GO
SOURCE 00_Database_Setup/setup_database_completo.sql

-- Executar script de verificação:
SOURCE 00_Database_Setup/verificar_banco_dados.sql
GO

-- Caso seja necessário excluir o database RoadmapEngenhariaDados
    USE master; -- Switch to the master database
    O

    -- Force disconnections and delete the database
    ALTER DATABASE RoadmapEngenhariaDados SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    GO
    DROP DATABASE RoadmapEngenhariaDados;
    GO