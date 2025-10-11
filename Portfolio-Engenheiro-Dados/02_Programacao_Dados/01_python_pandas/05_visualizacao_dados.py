"""
📊 [05] Pandas - Visualização de Dados
Mês 2: Programação & Bancos - Aula 5

Objetivos:
- Criar visualizações com Matplotlib e Seaborn
- Análise exploratória com gráficos
- Customização de visualizações
- Dashboard simples com múltiplos gráficos
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from datetime import datetime, timedelta

# Configuração do estilo dos gráficos
plt.style.use('seaborn-v0_8')
sns.set_palette("husl")
plt.rcParams['figure.figsize'] = (12, 8)

def criar_dados_visualizacao():
    """Cria dataset rico para visualizações"""
    
    print("🎨 CRIANDO DATASET PARA VISUALIZAÇÕES")
    print("=" * 50)
    
    np.random.seed(42)
    
    # Dados de vendas com múltiplas dimensões
    dados = []
    categorias = ['Eletrônicos', 'Roupas', 'Casa', 'Alimentação', 'Esportes']
    regioes = ['Norte', 'Nordeste', 'Centro-Oeste', 'Sudeste', 'Sul']
    
    for i in range(1000):
        categoria = np.random.choice(categorias, p=[0.3, 0.25, 0.2, 0.15, 0.1])
        regiao = np.random.choice(regioes)
        
        # Valores base por categoria
        valores_base = {
            'Eletrônicos': (800, 300),
            'Roupas': (150, 50),
            'Casa': (300, 100),
            'Alimentação': (80, 20),
            'Esportes': (200, 60)
        }
        
        base, desvio = valores_base[categoria]
        valor_venda = max(10, np.random.normal(base, desvio))
        
        dados.append({
            'venda_id': 1000 + i,
            'data_venda': datetime(2024, 1, 1) + timedelta(days=np.random.randint(0, 180)),
            'categoria': categoria,
            'regiao': regiao,
            'valor_venda': valor_venda,
            'quantidade': np.random.randint(1, 5),
            'cliente_tipo': np.random.choice(['Novo', 'Recorrente', 'VIP'], p=[0.4, 0.5, 0.1]),
            'desconto': np.random.choice([0, 5, 10, 15], p=[0.6, 0.2, 0.15, 0.05])
        })
    
    df = pd.DataFrame(dados)
    df['valor_total'] = df['valor_venda'] * df['quantidade'] * (1 - df['desconto']/100)
    
    # Adicionar componentes de data
    df['mes'] = df['data_venda'].dt.month
    df['dia_semana'] = df['data_venda'].dt.day_name()
    df['trimestre'] = df['data_venda'].dt.quarter
    
    print(f"📊 Dataset criado: {len(df)} vendas")
    print(f"📅 Período: {df['data_venda'].min().date()} a {df['data_venda'].max().date()}")
    print("\nPrimeiras 5 vendas:")
    print(df.head())
    
    return df

def graficos_basicos(df):
    """Demonstra gráficos básicos com Matplotlib"""
    
    print("\n" + "=" * 50)
    print("📈 GRÁFICOS BÁSICOS - MATPLOTLIB")
    print("=" * 50)
    
    # 1. Gráfico de Barras - Vendas por Categoria
    print("1. 📊 GRÁFICO DE BARRAS - Vendas por Categoria")
    
    vendas_por_categoria = df.groupby('categoria')['valor_total'].sum().sort_values(ascending=False)
    
    plt.figure(figsize=(10, 6))
    plt.bar(vendas_por_categoria.index, vendas_por_categoria.values, color='skyblue', edgecolor='navy')
    plt.title('Vendas Totais por Categoria', fontsize=14, fontweight='bold')
    plt.xlabel('Categoria', fontsize=12)
    plt.ylabel('Valor Total (R$)', fontsize=12)
    plt.xticks(rotation=45)
    plt.grid(axis='y', alpha=0.3)
    
    # Adicionar valores nas barras
    for i, v in enumerate(vendas_por_categoria.values):
        plt.text(i, v + 1000, f'R$ {v:,.0f}', ha='center', va='bottom', fontweight='bold')
    
    plt.tight_layout()
    plt.savefig('02_Programacao_Dados/dados/grafico_barras_categoria.png', dpi=300, bbox_inches='tight')
    plt.show()
    
    # 2. Gráfico de Pizza - Distribuição de Vendas por Região
    print("\n2. 🥧 GRÁFICO DE PIZZA - Distribuição por Região")
    
    vendas_por_regiao = df.groupby('regiao')['valor_total'].sum()
    
    plt.figure(figsize=(8, 8))
    colors = ['#ff9999', '#66b3ff', '#99ff99', '#ffcc99', '#ff99cc']
    plt.pie(vendas_por_regiao.values, labels=vendas_por_regiao.index, autopct='%1.1f%%', 
            colors=colors, startangle=90)
    plt.title('Distribuição de Vendas por Região', fontsize=14, fontweight='bold')
    plt.savefig('02_Programacao_Dados/dados/grafico_pizza_regiao.png', dpi=300, bbox_inches='tight')
    plt.show()
    
    # 3. Histograma - Distribuição de Valores de Venda
    print("\n3. 📊 HISTOGRAMA - Distribuição de Valores de Venda")
    
    plt.figure(figsize=(10, 6))
    plt.hist(df['valor_total'], bins=30, color='lightgreen', edgecolor='black', alpha=0.7)
    plt.title('Distribuição de Valores de Venda', fontsize=14, fontweight='bold')
    plt.xlabel('Valor da Venda (R$)', fontsize=12)
    plt.ylabel('Frequência', fontsize=12)
    plt.grid(axis='y', alpha=0.3)
    
    # Adicionar linhas de média e mediana
    media = df['valor_total'].mean()
    mediana = df['valor_total'].median()
    
    plt.axvline(media, color='red', linestyle='--', linewidth=2, label=f'Média: R$ {media:.2f}')
    plt.axvline(mediana, color='blue', linestyle='--', linewidth=2, label=f'Mediana: R$ {mediana:.2f}')
    plt.legend()
    
    plt.savefig('02_Programacao_Dados/dados/histograma_valores.png', dpi=300, bbox_inches='tight')
    plt.show()

def graficos_seaborn_avancados(df):
    """Demonstra gráficos avançados com Seaborn"""
    
    print("\n" + "=" * 50)
    print("🎨 GRÁFICOS AVANÇADOS - SEABORN")
    print("=" * 50)
    
    # 1. Boxplot - Vendas por Categoria
    print("1. 📦 BOXPLOT - Vendas por Categoria")
    
    plt.figure(figsize=(12, 6))
    sns.boxplot(data=df, x='categoria', y='valor_total', hue='categoria', legend=False)
    plt.title('Distribuição de Vendas por Categoria', fontsize=14, fontweight='bold')
    plt.xlabel('Categoria', fontsize=12)
    plt.ylabel('Valor Total (R$)', fontsize=12)
    plt.xticks(rotation=45)
    plt.grid(axis='y', alpha=0.3)
    plt.savefig('02_Programacao_Dados/dados/boxplot_categorias.png', dpi=300, bbox_inches='tight')
    plt.show()
    
    # 2. Violin Plot - Vendas por Região e Tipo de Cliente
    print("\n2. 🎻 VIOLIN PLOT - Vendas por Região e Tipo de Cliente")
    
    plt.figure(figsize=(14, 8))
    sns.violinplot(data=df, x='regiao', y='valor_total', hue='cliente_tipo', 
                   split=True, inner='quart', palette='Set2')
    plt.title('Distribuição de Vendas por Região e Tipo de Cliente', fontsize=14, fontweight='bold')
    plt.xlabel('Região', fontsize=12)
    plt.ylabel('Valor Total (R$)', fontsize=12)
    plt.legend(title='Tipo de Cliente')
    plt.grid(axis='y', alpha=0.3)
    plt.savefig('02_Programacao_Dados/dados/violinplot_regiao_cliente.png', dpi=300, bbox_inches='tight')
    plt.show()
    
    # 3. Heatmap - Correlação entre Variáveis
    print("\n3. 🔥 HEATMAP - Correlação entre Variáveis")
    
    # Selecionar colunas numéricas para correlação
    colunas_numericas = ['valor_venda', 'quantidade', 'desconto', 'valor_total', 'mes']
    correlacao = df[colunas_numericas].corr()
    
    plt.figure(figsize=(10, 8))
    mask = np.triu(np.ones_like(correlacao, dtype=bool))  # Mascarar o triângulo superior
    sns.heatmap(correlacao, mask=mask, annot=True, cmap='coolwarm', center=0,
                square=True, linewidths=0.5, cbar_kws={"shrink": 0.8})
    plt.title('Matriz de Correlação entre Variáveis', fontsize=14, fontweight='bold')
    plt.savefig('02_Programacao_Dados/dados/heatmap_correlacao.png', dpi=300, bbox_inches='tight')
    plt.show()
    
    # 4. Pair Plot - Relações entre Variáveis
    print("\n4. 🔄 PAIR PLOT - Relações entre Variáveis")
    
    # Amostrar para não sobrecarregar o gráfico
    df_amostra = df.sample(200, random_state=42)
    
    g = sns.pairplot(df_amostra[['valor_venda', 'quantidade', 'desconto', 'valor_total', 'categoria']], 
                     hue='categoria', diag_kind='hist', palette='viridis')
    g.fig.suptitle('Pair Plot - Relações entre Variáveis por Categoria', y=1.02, fontsize=14, fontweight='bold')
    plt.savefig('02_Programacao_Dados/dados/pairplot_relacoes.png', dpi=300, bbox_inches='tight')
    plt.show()

def analise_temporal_visual(df):
    """Análise temporal com visualizações"""
    
    print("\n" + "=" * 50)
    print("⏰ ANÁLISE TEMPORAL - VISUALIZAÇÕES")
    print("=" * 50)
    
    # 1. Série Temporal - Vendas ao Longo do Tempo
    print("1. 📈 SÉRIE TEMPORAL - Vendas ao Longo do Tempo")
    
    # Agrupar por data
    vendas_diarias = df.groupby(df['data_venda'].dt.date)['valor_total'].sum()
    
    plt.figure(figsize=(14, 6))
    plt.plot(vendas_diarias.index, vendas_diarias.values, linewidth=2, color='royalblue', alpha=0.7)
    
    # Adicionar média móvel
    media_movel = vendas_diarias.rolling(window=7).mean()
    plt.plot(media_movel.index, media_movel.values, linewidth=2, color='red', 
             label='Média Móvel 7 dias')
    
    plt.title('Evolução das Vendas Diárias', fontsize=14, fontweight='bold')
    plt.xlabel('Data', fontsize=12)
    plt.ylabel('Valor Total de Vendas (R$)', fontsize=12)
    plt.legend()
    plt.grid(True, alpha=0.3)
    plt.xticks(rotation=45)
    plt.tight_layout()
    plt.savefig('02_Programacao_Dados/dados/serie_temporal_vendas.png', dpi=300, bbox_inches='tight')
    plt.show()
    
    # 2. Gráfico de Barras Agrupadas - Vendas Mensais por Categoria
    print("\n2. 📊 VENDAS MENSAS POR CATEGORIA")
    
    vendas_mensais_categoria = df.groupby(['mes', 'categoria'])['valor_total'].sum().unstack()
    
    plt.figure(figsize=(14, 8))
    vendas_mensais_categoria.plot(kind='bar', ax=plt.gca(), width=0.8)
    plt.title('Vendas Mensais por Categoria', fontsize=14, fontweight='bold')
    plt.xlabel('Mês', fontsize=12)
    plt.ylabel('Valor Total (R$)', fontsize=12)
    plt.legend(title='Categoria')
    plt.grid(axis='y', alpha=0.3)
    plt.xticks(rotation=0)
    plt.tight_layout()
    plt.savefig('02_Programacao_Dados/dados/barras_mensais_categoria.png', dpi=300, bbox_inches='tight')
    plt.show()
    
    # 3. Heatmap Temporal - Vendas por Dia da Semana e Mês
    print("\n3. 🗓️ HEATMAP TEMPORAL - Vendas por Dia da Semana e Mês")
    
    # Criar pivot table para heatmap
    ordem_dias = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
    df['dia_semana'] = pd.Categorical(df['dia_semana'], categories=ordem_dias, ordered=True)
    
    heatmap_data = df.pivot_table(values='valor_total', index='dia_semana', 
                                 columns='mes', aggfunc='sum')
    
    plt.figure(figsize=(12, 8))
    sns.heatmap(heatmap_data, annot=True, fmt='.0f', cmap='YlOrRd', 
                cbar_kws={'label': 'Valor Total de Vendas (R$)'})
    plt.title('Vendas por Dia da Semana e Mês', fontsize=14, fontweight='bold')
    plt.xlabel('Mês', fontsize=12)
    plt.ylabel('Dia da Semana', fontsize=12)
    plt.tight_layout()
    plt.savefig('02_Programacao_Dados/dados/heatmap_temporal.png', dpi=300, bbox_inches='tight')
    plt.show()

def visualizacoes_interativas(df):
    """Visualizações interativas e avançadas"""
    
    print("\n" + "=" * 50)
    print("🎯 VISUALIZAÇÕES INTERATIVAS E AVANÇADAS")
    print("=" * 50)
    
    # 1. Scatter Plot com Tamanho e Cor
    print("1. 🔵 SCATTER PLOT AVANÇADO - Valor vs Quantidade")
    
    plt.figure(figsize=(12, 8))
    scatter = plt.scatter(df['valor_venda'], df['quantidade'], 
                         c=df['desconto'], s=df['valor_total']/50, 
                         alpha=0.6, cmap='viridis')
    plt.colorbar(scatter, label='Desconto (%)')
    plt.title('Relação entre Valor da Venda e Quantidade\n(Tamanho = Valor Total, Cor = Desconto)', 
              fontsize=14, fontweight='bold')
    plt.xlabel('Valor da Venda (R$)', fontsize=12)
    plt.ylabel('Quantidade', fontsize=12)
    plt.grid(True, alpha=0.3)
    plt.savefig('02_Programacao_Dados/dados/scatter_avancado.png', dpi=300, bbox_inches='tight')
    plt.show()
    
    # 2. Gráfico de Área - Acumulado de Vendas
    print("\n2. 📊 GRÁFICO DE ÁREA - Vendas Acumuladas por Categoria")
    
    # Ordenar por data e calcular acumulado
    df_sorted = df.sort_values('data_venda')
    vendas_acumuladas = df_sorted.groupby(['data_venda', 'categoria'])['valor_total'].sum().unstack().cumsum()
    
    plt.figure(figsize=(14, 8))
    vendas_acumuladas.plot(kind='area', ax=plt.gca(), alpha=0.7, stacked=True)
    plt.title('Vendas Acumuladas por Categoria ao Longo do Tempo', fontsize=14, fontweight='bold')
    plt.xlabel('Data', fontsize=12)
    plt.ylabel('Valor Total Acumulado (R$)', fontsize=12)
    plt.legend(title='Categoria')
    plt.grid(True, alpha=0.3)
    plt.xticks(rotation=45)
    plt.tight_layout()
    plt.savefig('02_Programacao_Dados/dados/area_acumulado.png', dpi=300, bbox_inches='tight')
    plt.show()

def criar_dashboard_resumo(df):
    """Cria um dashboard com múltiplos gráficos"""
    
    print("\n" + "=" * 50)
    print"📊 DASHBOARD DE RESUMO - MÚLTIPLOS GRÁFICOS")
    print("=" * 50)
    
    # Criar figura com subplots
    fig, axes = plt.subplots(2, 2, figsize=(16, 12))
    fig.suptitle('DASHBOARD DE ANÁLISE DE VENDAS', fontsize=16, fontweight='bold', y=0.98)
    
    # 1. Vendas por Categoria (Barras)
    vendas_categoria = df.groupby('categoria')['valor_total'].sum().sort_values(ascending=False)
    axes[0, 0].bar(vendas_categoria.index, vendas_categoria.values, color='lightblue', edgecolor='navy')
    axes[0, 0].set_title('Vendas por Categoria', fontweight='bold')
    axes[0, 0].set_ylabel('Valor Total (R$)')
    axes[0, 0].tick_params(axis='x', rotation=45)
    axes[0, 0].grid(axis='y', alpha=0.3)
    
    # Adicionar valores nas barras
    for i, v in enumerate(vendas_categoria.values):
        axes[0, 0].text(i, v + 1000, f'R$ {v:,.0f}', ha='center', va='bottom', fontsize=8)
    
    # 2. Distribuição de Valores (Histograma)
    axes[0, 1].hist(df['valor_total'], bins=30, color='lightgreen', edgecolor='black', alpha=0.7)
    axes[0, 1].set_title('Distribuição de Valores de Venda', fontweight='bold')
    axes[0, 1].set_xlabel('Valor da Venda (R$)')
    axes[0, 1].set_ylabel('Frequência')
    axes[0, 1].grid(alpha=0.3)
    
    # 3. Vendas por Região (Pizza)
    vendas_regiao = df.groupby('regiao')['valor_total'].sum()
    axes[1, 0].pie(vendas_regiao.values, labels=vendas_regiao.index, autopct='%1.1f%%', 
                   startangle=90)
    axes[1, 0].set_title('Distribuição por Região', fontweight='bold')
    
    # 4. Boxplot por Categoria
    df.boxplot(column='valor_total', by='categoria', ax=axes[1, 1])
    axes[1, 1].set_title('Distribuição por Categoria', fontweight='bold')
    axes[1, 1].set_ylabel('Valor Total (R$)')
    axes[1, 1].tick_params(axis='x', rotation=45)
    
    # Ajustar layout
    plt.tight_layout()
    plt.savefig('02_Programacao_Dados/dados/dashboard_completo.png', dpi=300, bbox_inches='tight')
    plt.show()
    
    print("✅ Dashboard salvo como 'dashboard_completo.png'")

def relatorio_insights_visuais(df):
    """Gera relatório com insights das visualizações"""
    
    print("\n" + "=" * 50)
    print"💡 RELATÓRIO DE INSIGHTS VISUAIS")
    print("=" * 50)
    
    # Calcular métricas para insights
    faturamento_total = df['valor_total'].sum()
    media_venda = df['valor_total'].mean()
    melhor_categoria = df.groupby('categoria')['valor_total'].sum().idxmax()
    pior_categoria = df.groupby('categoria')['valor_total'].sum().idxmin()
    melhor_regiao = df.groupby('regiao')['valor_total'].sum().idxmax()
    
    # Variação entre melhor e pior categoria
    fat_categorias = df.groupby('categoria')['valor_total'].sum()
    variacao_categorias = (fat_categorias.max() - fat_categorias.min()) / fat_categorias.min() * 100
    
    print("📊 MÉTRICAS PRINCIPAIS:")
    print(f"   • Faturamento Total: R$ {faturamento_total:,.2f}")
    print(f"   • Ticket Médio: R$ {media_venda:.2f}")
    print(f"   • Total de Vendas: {len(df)}")
    
    print("\n🎯 INSIGHTS DAS VISUALIZAÇÕES:")
    print(f"   1. Categoria Líder: {melhor_categoria} (foco em expansão)")
    print(f"   2. Categoria com Menor Performance: {pior_categoria} (necessita de atenção)")
    print(f"   3. Melhor Região: {melhor_regiao} (modelo a ser replicado)")
    print(f"   4. Variação entre Categorias: {variacao_categorias:.1f}% (oportunidade de balanceamento)")
    
    print("\n📈 RECOMENDAÇÕES ESTRATÉGICAS:")
    print("   1. Investir em marketing para a categoria de menor performance")
    print("   2. Estudar o sucesso da região líder para replicar em outras")
    print("   3. Desenvolver promoções específicas por categoria")
    print("   4. Monitorar sazonalidade para planejamento de estoque")
    
    # Salvar métricas em arquivo
    insights = {
        'faturamento_total': faturamento_total,
        'ticket_medio': media_venda,
        'melhor_categoria': melhor_categoria,
        'pior_categoria': pior_categoria,
        'melhor_regiao': melhor_regiao,
        'total_vendas': len(df)
    }
    
    # Criar diretório se não existir
    import os
    os.makedirs('02_Programacao_Dados/dados', exist_ok=True)
    
    # Salvar insights em CSV
    pd.DataFrame([insights]).to_csv('02_Programacao_Dados/dados/insights_visuais.csv', index=False)
    print(f"\n💾 Insights salvos em '02_Programacao_Dados/dados/insights_visuais.csv'")

def main():
    """Função principal"""
    print("🚀 VISUALIZAÇÃO DE DADOS COM PANDAS, MATPLOTLIB E SEABORN")
    print("=" * 70)
    
    # Criar diretório para salvar gráficos
    import os
    os.makedirs('02_Programacao_Dados/dados', exist_ok=True)
    
    # 1. Criar dados para visualização
    df = criar_dados_visualizacao()
    
    # 2. Gráficos básicos com Matplotlib
    graficos_basicos(df)
    
    # 3. Gráficos avançados com Seaborn
    graficos_seaborn_avancados(df)
    
    # 4. Análise temporal com visualizações
    analise_temporal_visual(df)
    
    # 5. Visualizações interativas
    visualizacoes_interativas(df)
    
    # 6. Dashboard completo
    criar_dashboard_resumo(df)
    
    # 7. Relatório de insights
    relatorio_insights_visuais(df)
    
    print("\n" + "=" * 70)
    print("✅ VISUALIZAÇÃO DE DADOS DOMINADA!")
    print("🎯 SEMANA 1 DE PANDAS - CONCLUÍDA COM SUCESSO!")
    print("📚 PRÓXIMO: SQL Server Avançado")
    print("=" * 70)

if __name__ == "__main__":
    main()