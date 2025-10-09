
# 🔄 SQL Intermediário - Semana 3

## 🎯 Objetivos da Semana
- [ ] Dominar JOINs entre tabelas
- [ ] Compreender GROUP BY e agregações
- [ ] Praticar consultas com múltiplas tabelas

## 📚 Cursos da Semana
- *Udemy:* "SQL para Análise de Dados" - Módulos 4-6
- *DIO:* "SQL Intermediário" ou continuar bootcamp

## 📝 Conteúdo Teórico

### 1. JOINs - Relacionando Tabelas
```sql
-- INNER JOIN: Apenas registros que existem em ambas as tabelas
SELECT *
FROM tabelaA
INNER JOIN tabelaB ON tabelaA.id = tabelaB.tabelaA_id;

-- LEFT JOIN: Todos da tabelaA + correspondentes da tabelaB
SELECT *
FROM tabelaA
LEFT JOIN tabelaB ON tabelaA.id = tabelaB.tabelaA_id;