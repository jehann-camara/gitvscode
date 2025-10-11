# 🗃️ SETUP DOS BANCO DE DADOS - ROADMAP ENGENHARIA DE DADOS

## 📋 OBJETIVO
Este diretório contém os scripts para criar e configurar **dois ambientes de banco de dados** que serão utilizados ao longo dos 7 meses do roadmap.

## 🎯 DOIS DATABASES COMPLEMENTARES

### 1. `estudos_sql` (Mês 1-2)
- **Foco:** Exercícios simples e aprendizado inicial
- **Estrutura:** Tabelas básicas sem schemas complexos
- **Uso:** Fundamentos de SQL, consultas básicas

### 2. `RoadmapEngenhariaDados` (Mês 3-7)  
- **Foco:** Projetos reais e arquitetura profissional
- **Estrutura:** Schemas organizados (bronze/silver/gold)
- **Uso:** Modelagem dimensional, ETL, orquestração

## 🚀 COMO USAR

### OPÇÃO 1: SETUP INDIVIDUAL

# Para exercícios do Mês 1 (SQL básico)
SOURCE 00_Database_Setup/setup_estudos_sql.sql

# Para projetos dos Meses 3-7
SOURCE 00_Database_Setup/setup_database_completo.sql

### OPÇÃO 2: SETUP COMPLETO
-- Criar ambos os databases
SOURCE 00_Database_Setup/setup_todos_databases.sql