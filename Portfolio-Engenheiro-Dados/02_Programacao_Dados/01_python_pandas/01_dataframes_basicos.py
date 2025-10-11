"""
📊 [01] Pandas - DataFrames Básicos
Mês 2: Programação & Bancos - Aula 1

Objetivos:
- Criar DataFrames a partir de diferentes fontes
- Operações básicas com DataFrames
- Exploração inicial de dados
"""

import pandas as pd
import numpy as np
from datetime import datetime

def criar_dataframes_exemplo():
    """Demonstra diferentes formas de criar DataFrames"""
    
    print("🐍 PANDAS DATAFRAMES - FUNDAMENTOS")
    print("=" * 50)
    
    # 1. DataFrame a partir de dicionário
    print("\n1. 📝 DATAFRAME A PARTIR DE DICIONÁRIO:")
    dados_clientes = {
        'id': [1, 2, 3, 4, 5],
        'nome': ['Ana Silva', 'Carlos Oliveira', 'Marina Santos', 'João Pereira', 'Juliana Costa'],
        'idade': [28, 35, 22, 42, 29],
        'cidade': ['São Paulo', 'Rio de Janeiro', 'Belo Horizonte', 'São Paulo', 'Curitiba'],
        'salario': [5000.00, 7500.50, 3200.00, 8500.75, 4800.00],
        'data_cadastro': ['2024-01-15', '2024-01-20', '2024-02-01', '2024-02-10', '2024-02-15']
    }
    
    df_clientes = pd.DataFrame(dados_clientes)
    print("DataFrame criado:")
    print(df_clientes)
    
    # 2. DataFrame a partir de lista de listas
    print("\n2. 📋 DATAFRAME A PARTIR DE LISTA DE LISTAS:")
    dados_produtos = [
        [1, 'Notebook Dell', 2500.00, 'Eletrônicos', 15],
        [2, 'Mouse Wireless', 89.90, 'Acessórios', 50],
        [3, 'Teclado Mecânico', 299.90, 'Acessórios', 30],
        [4, 'Monitor 24"', 899.00, 'Eletrônicos', 20],
        [5, 'Tablet Samsung', 1200.00, 'Eletrônicos', 10]
    ]
    
    colunas_produtos = ['id', 'nome', 'preco', 'categoria', 'estoque']
    df_produtos = pd.DataFrame(dados_produtos, columns=colunas_produtos)
    print("DataFrame produtos:")
    print(df_produtos)
    
    return df_clientes, df_produtos

def operacoes_basicas_dataframes(df_clientes, df_produtos):
    """Demonstra operações básicas com DataFrames"""
    
    print("\n" + "=" * 50)
    print("🔧 OPERAÇÕES BÁSICAS COM DATAFRAMES")
    print("=" * 50)
    
    # 1. Informações básicas do DataFrame
    print("\n1. 📊 INFORMAÇÕES DO DATAFRAME CLIENTES:")
    print(f"   Dimensões: {df_clientes.shape}")  # (linhas, colunas)
    print(f"   Colunas: {list(df_clientes.columns)}")
    print(f"   Total de células: {df_clientes.size}")
    
    # 2. Primeiras e últimas linhas
    print("\n2. 👀 PRIMEIRAS E ÚLTIMAS LINHAS:")
    print("   Primeiras 3 linhas:")
    print(df_clientes.head(3))
    print("\n   Últimas 2 linhas:")
    print(df_clientes.tail(2))
    
    # 3. Estatísticas descritivas
    print("\n3. 📈 ESTATÍSTICAS DESCRITIVAS:")
    print("   Colunas numéricas:")
    print(df_clientes[['idade', 'salario']].describe())
    
    # 4. Informações sobre tipos de dados
    print("\n4. 🔍 TIPOS DE DADOS E INFORMAÇÕES:")
    print("   Tipos de dados:")
    print(df_clientes.dtypes)
    print("\n   Informações completas:")
    df_clientes.info()
    
    # 5. Valores únicos e contagens
    print("\n5. 🎯 VALORES ÚNICOS E CONTAGENS:")
    print("   Cidades únicas:")
    print(df_clientes['cidade'].unique())
    print("\n   Contagem por cidade:")
    print(df_clientes['cidade'].value_counts())

def selecionar_dados_dataframes(df_clientes, df_produtos):
    """Demonstra diferentes formas de selecionar dados"""
    
    print("\n" + "=" * 50)
    print("🎯 SELEÇÃO DE DADOS EM DATAFRAMES")
    print("=" * 50)
    
    # 1. Seleção de colunas
    print("\n1. 📍 SELEÇÃO DE COLUNAS:")
    print("   Apenas nomes e idades:")
    print(df_clientes[['nome', 'idade']])
    
    # 2. Seleção de linhas por índice
    print("\n2. 🔢 SELEÇÃO POR ÍNDICE:")
    print("   Linhas 1 a 3:")
    print(df_clientes.iloc[1:4])
    
    # 3. Filtros com condições
    print("\n3. 🔍 FILTROS COM CONDIÇÕES:")
    print("   Clientes de São Paulo:")
    clientes_sp = df_clientes[df_clientes['cidade'] == 'São Paulo']
    print(clientes_sp)
    
    print("\n   Clientes com salário > 4000:")
    clientes_salario_alto = df_clientes[df_clientes['salario'] > 4000]
    print(clientes_salario_alto)
    
    print("\n   Clientes entre 25 e 35 anos:")
    clientes_idade = df_clientes[(df_clientes['idade'] >= 25) & (df_clientes['idade'] <= 35)]
    print(clientes_idade)
    
    # 4. Ordenação
    print("\n4. 📊 ORDENAÇÃO DE DADOS:")
    print("   Ordenado por salário (decrescente):")
    print(df_clientes.sort_values('salario', ascending=False))
    
    print("\n   Ordenado por cidade e idade:")
    print(df_clientes.sort_values(['cidade', 'idade']))

def manipular_colunas_dataframes(df_clientes):
    """Demonstra manipulação de colunas"""
    
    print("\n" + "=" * 50)
    print("🛠️ MANIPULAÇÃO DE COLUNAS")
    print("=" * 50)
    
    # Criar cópia para não modificar o original
    df_temp = df_clientes.copy()
    
    # 1. Adicionar nova coluna
    print("\n1. ➕ ADICIONAR NOVA COLUNA:")
    df_temp['faixa_etaria'] = df_temp['idade'].apply(
        lambda x: 'Jovem' if x < 30 else 'Adulto' if x < 40 else 'Senior'
    )
    print("   Coluna 'faixa_etaria' adicionada:")
    print(df_temp[['nome', 'idade', 'faixa_etaria']])
    
    # 2. Modificar coluna existente
    print("\n2. ✏️ MODIFICAR COLUNA EXISTENTE:")
    df_temp['salario_anual'] = df_temp['salario'] * 12
    print("   Salário anual calculado:")
    print(df_temp[['nome', 'salario', 'salario_anual']])
    
    # 3. Renomear colunas
    print("\n3. 🏷️ RENOMEAR COLUNAS:")
    df_temp_renomeado = df_temp.rename(columns={
        'nome': 'nome_completo',
        'cidade': 'cidade_residencia'
    })
    print("   Colunas renomeadas:")
    print(df_temp_renomeado.columns.tolist())
    
    # 4. Excluir colunas
    print("\n4. 🗑️ EXCLUIR COLUNAS:")
    df_temp_sem_colunas = df_temp.drop(['data_cadastro', 'salario_anual'], axis=1)
    print("   Colunas restantes:")
    print(df_temp_sem_colunas.columns.tolist())
    
    return df_temp

def salvar_carregar_dataframes(df_clientes, df_produtos):
    """Demonstra operações de salvar e carregar DataFrames"""
    
    print("\n" + "=" * 50)
    print"💾 SALVAR E CARREGAR DATAFRAMES")
    print("=" * 50)
    
    import os
    
    # Criar diretório de dados se não existir
    os.makedirs('02_Programacao_Dados/dados', exist_ok=True)
    
    # 1. Salvar como CSV
    print("\n1. 📄 SALVAR COMO CSV:")
    caminho_csv = '02_Programacao_Dados/dados/clientes.csv'
    df_clientes.to_csv(caminho_csv, index=False)
    print(f"   DataFrame salvo em: {caminho_csv}")
    
    # 2. Salvar como Excel
    print("\n2. 📊 SALVAR COMO EXCEL:")
    caminho_excel = '02_Programacao_Dados/dados/produtos.xlsx'
    df_produtos.to_excel(caminho_excel, index=False)
    print(f"   DataFrame salvo em: {caminho_excel}")
    
    # 3. Carregar dados do CSV
    print("\n3. 🔄 CARREGAR DO CSV:")
    df_clientes_carregado = pd.read_csv(caminho_csv)
    print("   Dados carregados do CSV:")
    print(f"   Linhas: {len(df_clientes_carregado)}")
    print(f"   Colunas: {list(df_clientes_carregado.columns)}")
    
    # 4. Carregar dados do Excel
    print("\n4. 🔄 CARREGAR DO EXCEL:")
    df_produtos_carregado = pd.read_excel(caminho_excel)
    print("   Dados carregados do Excel:")
    print(f"   Linhas: {len(df_produtos_carregado)}")
    print(f"   Colunas: {list(df_produtos_carregado.columns)}")

def exercicios_praticos():
    """Exercícios para praticar os conceitos aprendidos"""
    
    print("\n" + "=" * 50)
    print"🎯 EXERCÍCIOS PRÁTICOS")
    print("=" * 50)
    
    # Dados para exercícios
    dados_vendas = {
        'venda_id': [101, 102, 103, 104, 105, 106],
        'cliente_id': [1, 2, 1, 3, 4, 2],
        'produto_id': [1, 2, 3, 1, 4, 2],
        'quantidade': [1, 2, 1, 1, 3, 1],
        'valor_total': [2500.00, 179.80, 299.90, 2500.00, 3600.00, 179.80],
        'data_venda': ['2024-02-01', '2024-02-01', '2024-02-02', '2024-02-03', '2024-02-04', '2024-02-05']
    }
    
    df_vendas = pd.DataFrame(dados_vendas)
    
    print("📦 DATAFRAME VENDAS:")
    print(df_vendas)
    
    print("\n💪 DESAFIOS:")
    print("1. Selecione apenas as vendas com valor total maior que 1000")
    print("2. Calcule o total de vendas por cliente")
    print("3. Encontre a venda com maior valor")
    print("4. Adicione uma coluna 'desconto' com 10% do valor total")
    print("5. Salve o DataFrame como CSV")
    
    return df_vendas

def main():
    """Função principal"""
    print("🚀 INICIANDO APRENDIZADO DE PANDAS DATAFRAMES")
    print("=" * 60)
    
    # 1. Criar DataFrames de exemplo
    df_clientes, df_produtos = criar_dataframes_exemplo()
    
    # 2. Operações básicas
    operacoes_basicas_dataframes(df_clientes, df_produtos)
    
    # 3. Seleção de dados
    selecionar_dados_dataframes(df_clientes, df_produtos)
    
    # 4. Manipulação de colunas
    df_modificado = manipular_colunas_dataframes(df_clientes)
    
    # 5. Salvar e carregar
    salvar_carregar_dataframes(df_clientes, df_produtos)
    
    # 6. Exercícios práticos
    df_vendas = exercicios_praticos()
    
    print("\n" + "=" * 60)
    print("✅ CONCEITOS DE DATAFRAMES DOMINADOS!")
    print("🎯 PRÓXIMO: Operações avançadas com DataFrames")
    print("=" * 60)

if __name__ == "__main__":
    main()