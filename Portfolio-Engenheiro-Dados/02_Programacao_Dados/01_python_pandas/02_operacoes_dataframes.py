"""
📊 [02] Pandas - Operações com DataFrames
Mês 2: Programação & Bancos - Aula 2

Objetivos:
- Operações de agregação e groupby
- Trabalhar com dados faltantes
- Aplicar funções personalizadas
- Combinar DataFrames
"""

import pandas as pd
import numpy as np

def criar_dados_exemplo():
    """Cria dados de exemplo para as operações"""
    
    print("📊 CRIANDO DADOS DE EXEMPLO PARA OPERAÇÕES")
    print("=" * 50)
    
    # Dados de vendas mais complexos
    dados_vendas = {
        'venda_id': range(1001, 1021),
        'cliente_id': [1, 2, 1, 3, 4, 2, 5, 1, 3, 4, 2, 5, 1, 3, 4, 2, 5, 1, 3, 4],
        'produto_id': [1, 2, 3, 1, 4, 2, 5, 3, 1, 4, 2, 5, 1, 3, 4, 2, 5, 1, 3, 4],
        'quantidade': [1, 2, 1, 1, 3, 1, 2, 1, 1, 2, 1, 1, 2, 1, 3, 1, 2, 1, 1, 2],
        'valor_total': [2500, 180, 300, 2500, 3600, 180, 600, 300, 2500, 2400, 180, 600, 5000, 300, 3600, 180, 600, 2500, 300, 2400],
        'categoria': ['Eletrônicos', 'Acessórios', 'Acessórios', 'Eletrônicos', 'Eletrônicos', 
                     'Acessórios', 'Eletrônicos', 'Acessórios', 'Eletrônicos', 'Eletrônicos',
                     'Acessórios', 'Eletrônicos', 'Eletrônicos', 'Acessórios', 'Eletrônicos',
                     'Acessórios', 'Eletrônicos', 'Eletrônicos', 'Acessórios', 'Eletrônicos'],
        'data_venda': pd.date_range('2024-01-01', periods=20, freq='D')
    }
    
    df_vendas = pd.DataFrame(dados_vendas)
    
    # Adicionar alguns valores faltantes para exemplos
    df_vendas.loc[2, 'valor_total'] = np.nan
    df_vendas.loc[5, 'quantidade'] = np.nan
    df_vendas.loc[8, 'categoria'] = None
    
    print("DataFrame Vendas (com valores faltantes):")
    print(df_vendas.head(10))
    print(f"\nDimensões: {df_vendas.shape}")
    
    return df_vendas

def operacoes_agregacao(df_vendas):
    """Demonstra operações de agregação"""
    
    print("\n" + "=" * 50)
    print("📈 OPERAÇÕES DE AGREGAÇÃO")
    print("=" * 50)
    
    # 1. Agregações básicas
    print("1. 📊 AGREGAÇÕES BÁSICAS:")
    print(f"   Soma total de vendas: R$ {df_vendas['valor_total'].sum():.2f}")
    print(f"   Média de valor por venda: R$ {df_vendas['valor_total'].mean():.2f}")
    print(f"   Maior venda: R$ {df_vendas['valor_total'].max():.2f}")
    print(f"   Menor venda: R$ {df_vendas['valor_total'].min():.2f}")
    print(f"   Total de vendas: {df_vendas['venda_id'].count()}")
    
    # 2. Múltiplas agregações
    print("\n2. 🔢 MÚLTIPLAS AGREGAÇÕES:")
    agregacoes = df_vendas.agg({
        'valor_total': ['sum', 'mean', 'max', 'min', 'std'],
        'quantidade': ['sum', 'mean', 'max', 'min']
    })
    print(agregacoes)

def groupby_operacoes(df_vendas):
    """Demonstra operações com groupby"""
    
    print("\n" + "=" * 50)
    print("👥 OPERAÇÕES COM GROUPBY")
    print("=" * 50)
    
    # 1. Groupby simples
    print("1. 📊 VENDAS POR CATEGORIA:")
    vendas_por_categoria = df_vendas.groupby('categoria')['valor_total'].sum()
    print(vendas_por_categoria)
    
    # 2. Múltiplas agregações por grupo
    print("\n2. 📈 ESTATÍSTICAS POR CATEGORIA:")
    stats_categoria = df_vendas.groupby('categoria').agg({
        'valor_total': ['sum', 'mean', 'count', 'std'],
        'quantidade': ['sum', 'mean']
    })
    print(stats_categoria)
    
    # 3. Groupby com múltiplas colunas
    print("\n3. 🔍 VENDAS POR CLIENTE E CATEGORIA:")
    vendas_cliente_categoria = df_vendas.groupby(['cliente_id', 'categoria']).agg({
        'valor_total': 'sum',
        'quantidade': 'sum',
        'venda_id': 'count'
    }).rename(columns={'venda_id': 'total_vendas'})
    print(vendas_cliente_categoria)
    
    # 4. Agregações com funções personalizadas
    print("\n4. 🎯 AGREGAÇÕES PERSONALIZADAS:")
    
    def faixa_valor(valores):
        """Classifica como Alta ou Baixa venda baseado na média"""
        media = valores.mean()
        return 'Alta' if media > 1000 else 'Baixa'
    
    classificacao = df_vendas.groupby('cliente_id')['valor_total'].agg([
        ('total_vendas', 'sum'),
        ('media_vendas', 'mean'),
        ('tipo_cliente', faixa_valor)
    ])
    print(classificacao)

def trabalhar_dados_faltantes(df_vendas):
    """Demonstra tratamento de dados faltantes"""
    
    print("\n" + "=" * 50)
    print("🔍 TRABALHANDO COM DADOS FALTANTES")
    print("=" * 50)
    
    print("DataFrame original (primeiras 10 linhas):")
    print(df_vendas.head(10))
    
    # 1. Identificar dados faltantes
    print("\n1. 📋 IDENTIFICAR DADOS FALTANTES:")
    print("   Valores faltantes por coluna:")
    print(df_vendas.isnull().sum())
    
    print("\n   Porcentagem de dados faltantes:")
    print((df_vendas.isnull().sum() / len(df_vendas) * 100).round(2))
    
    # 2. Estratégias para tratar dados faltantes
    print("\n2. 🛠️ ESTRATÉGIAS DE TRATAMENTO:")
    
    # a) Remover linhas com dados faltantes
    df_sem_nulos = df_vendas.dropna()
    print(f"   a) Removendo nulos: {len(df_sem_nulos)} linhas restantes")
    
    # b) Preencher com valor específico
    df_preenchido_zero = df_vendas.fillna(0)
    print("   b) Preenchendo com zero (primeiras linhas):")
    print(df_preenchido_zero.head(10))
    
    # c) Preencher com média
    df_preenchido_media = df_vendas.copy()
    df_preenchido_media['valor_total'].fillna(df_preenchido_media['valor_total'].mean(), inplace=True)
    df_preenchido_media['quantidade'].fillna(df_preenchido_media['quantidade'].mean(), inplace=True)
    df_preenchido_media['categoria'].fillna('Não Especificado', inplace=True)
    
    print("\n   c) Preenchendo com média/moda:")
    print(df_preenchido_media.head(10))
    
    # d) Preencher com método forward fill
    df_ffill = df_vendas.fillna(method='ffill')
    print("\n   d) Preenchendo com forward fill:")
    print(df_ffill.head(10))
    
    return df_preenchido_media

def funções_personalizadas(df_vendas):
    """Demonstra aplicação de funções personalizadas"""
    
    print("\n" + "=" * 50)
    print"🎯 FUNÇÕES PERSONALIZADAS")
    print("=" * 50)
    
    # 1. Aplicar função a uma coluna
    print("1. 📊 APLICAR FUNÇÃO A UMA COLUNA:")
    
    def classificar_venda(valor):
        if valor > 2000:
            return 'Alta'
        elif valor > 500:
            return 'Média'
        else:
            return 'Baixa'
    
    df_vendas['classificacao_venda'] = df_vendas['valor_total'].apply(classificar_venda)
    print("   Classificação aplicada:")
    print(df_vendas[['valor_total', 'classificacao_venda']].head())
    
    # 2. Aplicar função a múltiplas colunas
    print("\n2. 🔄 APLICAR FUNÇÃO A MÚLTIPLAS COLUNAS:")
    
    def calcular_lucro(linha):
        """Calcula lucro assumindo 30% de margem"""
        return linha['valor_total'] * 0.3
    
    df_vendas['lucro_estimado'] = df_vendas.apply(calcular_lucro, axis=1)
    print("   Lucro estimado calculado:")
    print(df_vendas[['valor_total', 'lucro_estimado']].head())
    
    # 3. Funções lambda
    print("\n3. λ FUNÇÕES LAMBDA:")
    df_vendas['valor_com_imposto'] = df_vendas['valor_total'].apply(
        lambda x: x * 1.1 if x > 1000 else x * 1.05
    )
    print("   Imposto calculado com lambda:")
    print(df_vendas[['valor_total', 'valor_com_imposto']].head())
    
    # 4. Transform com funções
    print("\n4. 🔧 TRANSFORM COM FUNÇÕES:")
    
    def normalizar_valor(serie):
        """Normaliza os valores entre 0 e 1"""
        return (serie - serie.min()) / (serie.max() - serie.min())
    
    df_vendas['valor_normalizado'] = df_vendas.groupby('categoria')['valor_total'].transform(normalizar_valor)
    print("   Valores normalizados por categoria:")
    print(df_vendas[['categoria', 'valor_total', 'valor_normalizado']].head())

def combinar_dataframes():
    """Demonstra como combinar múltiplos DataFrames"""
    
    print("\n" + "=" * 50)
    print"🔄 COMBINAR DATAFRAMES")
    print("=" * 50)
    
    # Criar DataFrames para combinação
    df_clientes = pd.DataFrame({
        'cliente_id': [1, 2, 3, 4, 5],
        'nome': ['Ana Silva', 'Carlos Oliveira', 'Marina Santos', 'João Pereira', 'Juliana Costa'],
        'cidade': ['São Paulo', 'Rio de Janeiro', 'Belo Horizonte', 'São Paulo', 'Curitiba']
    })
    
    df_produtos = pd.DataFrame({
        'produto_id': [1, 2, 3, 4, 5],
        'nome': ['Notebook Dell', 'Mouse Wireless', 'Teclado Mecânico', 'Monitor 24"', 'Tablet Samsung'],
        'categoria': ['Eletrônicos', 'Acessórios', 'Acessórios', 'Eletrônicos', 'Eletrônicos']
    })
    
    df_vendas = pd.DataFrame({
        'venda_id': [1001, 1002, 1003, 1004],
        'cliente_id': [1, 2, 1, 3],
        'produto_id': [1, 2, 3, 1],
        'quantidade': [1, 2, 1, 1]
    })
    
    print("DataFrames originais:")
    print("Clientes:")
    print(df_clientes)
    print("\nProdutos:")
    print(df_produtos)
    print("\nVendas:")
    print(df_vendas)
    
    # 1. Merge (join) de DataFrames
    print("\n1. 🔗 MERGE (JOIN) DE DATAFRAMES:")
    
    # Merge vendas com clientes
    vendas_clientes = pd.merge(df_vendas, df_clientes, on='cliente_id')
    print("   Vendas + Clientes:")
    print(vendas_clientes)
    
    # Merge completo
    vendas_completo = pd.merge(vendas_clientes, df_produtos, on='produto_id')
    print("\n   Vendas + Clientes + Produtos:")
    print(vendas_completo)
    
    # 2. Concatenação
    print("\n2. 📎 CONCATENAÇÃO DE DATAFRAMES:")
    
    # Criar novo DataFrame com mesma estrutura
    novas_vendas = pd.DataFrame({
        'venda_id': [1005, 1006],
        'cliente_id': [4, 5],
        'produto_id': [4, 5],
        'quantidade': [1, 2]
    })
    
    # Concatenar
    todas_vendas = pd.concat([df_vendas, novas_vendas], ignore_index=True)
    print("   Todas as vendas (concatenadas):")
    print(todas_vendas)

def analise_avancada_exemplo(df_vendas):
    """Exemplo de análise avançada com todas as técnicas"""
    
    print("\n" + "=" * 50)
    print"📊 ANÁLISE AVANÇADA - EXEMPLO PRÁTICO")
    print("=" * 50)
    
    # Análise completa de performance de vendas
    analise_completa = df_vendas.groupby(['cliente_id', 'categoria']).agg({
        'valor_total': ['sum', 'mean', 'count'],
        'quantidade': 'sum'
    }).round(2)
    
    analise_completa.columns = ['total_vendido', 'ticket_medio', 'num_vendas', 'total_itens']
    analise_completa = analise_completa.reset_index()
    
    print("📈 ANÁLISE DE PERFORMANCE POR CLIENTE E CATEGORIA:")
    print(analise_completa)
    
    # Calcular métricas adicionais
    analise_completa['valor_por_item'] = analise_completa['total_vendido'] / analise_completa['total_itens']
    analise_completa['performance'] = analise_completa['total_vendido'].apply(
        lambda x: 'Alta' if x > 2000 else 'Média' if x > 500 else 'Baixa'
    )
    
    print("\n🎯 ANÁLISE COM MÉTRICAS AVANÇADAS:")
    print(analise_completa)

def main():
    """Função principal"""
    print("🚀 OPERAÇÕES AVANÇADAS COM PANDAS DATAFRAMES")
    print("=" * 60)
    
    # 1. Criar dados de exemplo
    df_vendas = criar_dados_exemplo()
    
    # 2. Operações de agregação
    operacoes_agregacao(df_vendas)
    
    # 3. Operações com groupby
    groupby_operacoes(df_vendas)
    
    # 4. Trabalhar com dados faltantes
    df_limpo = trabalhar_dados_faltantes(df_vendas)
    
    # 5. Funções personalizadas
    funções_personalizadas(df_limpo)
    
    # 6. Combinar DataFrames
    combinar_dataframes()
    
    # 7. Análise avançada
    analise_avancada_exemplo(df_limpo)
    
    print("\n" + "=" * 60)
    print("✅ OPERAÇÕES AVANÇADAS DOMINADAS!")
    print("🎯 PRÓXIMO: Trabalhando com datas e análise temporal")
    print("=" * 60)

if __name__ == "__main__":
    main()