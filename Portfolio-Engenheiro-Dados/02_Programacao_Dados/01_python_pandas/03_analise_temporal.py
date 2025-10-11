"""
📊 [03] Pandas - Análise Temporal e Datas
Mês 2: Programação & Bancos - Aula 3

Objetivos:
- Trabalhar com datas e timestamps
- Análise temporal de dados
- Agregações por períodos de tempo
- Séries temporais básicas
"""

import pandas as pd
import numpy as np
from datetime import datetime, timedelta

def criar_dados_temporais():
    """Cria dataset com dados temporais para análise"""
    
    print("📅 CRIANDO DADOS TEMPORAIS PARA ANÁLISE")
    print("=" * 50)
    
    # Gerar datas para os últimos 90 dias
    data_inicio = datetime(2024, 1, 1)
    datas = [data_inicio + timedelta(days=x) for x in range(90)]
    
    # Criar dados de vendas com sazonalidade
    np.random.seed(42)  # Para resultados consistentes
    
    dados_vendas = []
    venda_id = 1000
    
    for data in datas:
        # Vendas variam por dia da semana e tendência
        dia_semana = data.weekday()
        
        # Base de vendas com tendência crescente
        base_vendas = 50 + (data - data_inicio).days * 0.5
        
        # Efeito dia da semana (menos vendas fim de semana)
        if dia_semana >= 5:  # Fim de semana
            num_vendas = max(1, int(np.random.poisson(base_vendas * 0.3)))
        else:
            num_vendas = max(1, int(np.random.poisson(base_vendas)))
        
        for _ in range(num_vendas):
            venda_id += 1
            valor_venda = np.random.normal(150, 50)
            categoria = np.random.choice(['Eletrônicos', 'Roupas', 'Casa', 'Alimentação'], 
                                       p=[0.3, 0.25, 0.25, 0.2])
            
            dados_vendas.append({
                'venda_id': venda_id,
                'data_venda': data,
                'valor': max(10, valor_venda),  # Valor mínimo de 10
                'categoria': categoria,
                'quantidade': np.random.randint(1, 4),
                'cliente_id': np.random.randint(1, 51)
            })
    
    df_vendas = pd.DataFrame(dados_vendas)
    df_vendas['valor_total'] = df_vendas['valor'] * df_vendas['quantidade']
    
    print(f"📊 Dataset criado: {len(df_vendas)} vendas em {len(datas)} dias")
    print(f"📅 Período: {df_vendas['data_venda'].min()} a {df_vendas['data_venda'].max()}")
    print("\nPrimeiras 5 vendas:")
    print(df_vendas.head())
    
    return df_vendas

def trabalhar_com_datas(df_vendas):
    """Demonstra operações básicas com datas"""
    
    print("\n" + "=" * 50)
    print("📅 TRABALHANDO COM DATAS")
    print("=" * 50)
    
    # 1. Extrair componentes de data
    print("1. 🎯 EXTRAIR COMPONENTES DE DATA:")
    df_vendas['ano'] = df_vendas['data_venda'].dt.year
    df_vendas['mes'] = df_vendas['data_venda'].dt.month
    df_vendas['dia'] = df_vendas['data_venda'].dt.day
    df_vendas['dia_semana'] = df_vendas['data_venda'].dt.dayofweek
    df_vendas['nome_dia_semana'] = df_vendas['data_venda'].dt.day_name()
    df_vendas['semana_ano'] = df_vendas['data_venda'].dt.isocalendar().week
    df_vendas['trimestre'] = df_vendas['data_venda'].dt.quarter
    
    print("   Componentes extraídos:")
    print(df_vendas[['data_venda', 'ano', 'mes', 'dia', 'nome_dia_semana', 'trimestre']].head())
    
    # 2. Filtrar por datas
    print("\n2. 🔍 FILTRAR POR DATAS:")
    
    # Vendas de janeiro
    vendas_janeiro = df_vendas[df_vendas['data_venda'].dt.month == 1]
    print(f"   Vendas em janeiro: {len(vendas_janeiro)}")
    
    # Vendas após data específica
    data_corte = datetime(2024, 2, 1)
    vendas_fevereiro_marco = df_vendas[df_vendas['data_venda'] >= data_corte]
    print(f"   Vendas a partir de 01/02/2024: {len(vendas_fevereiro_marco)}")
    
    # Vendas em um range de datas
    inicio = datetime(2024, 1, 15)
    fim = datetime(2024, 1, 31)
    vendas_intervalo = df_vendas[(df_vendas['data_venda'] >= inicio) & (df_vendas['data_venda'] <= fim)]
    print(f"   Vendas entre 15 e 31/01/2024: {len(vendas_intervalo)}")
    
    return df_vendas

def analise_agregacao_temporal(df_vendas):
    """Demonstra agregações por períodos temporais"""
    
    print("\n" + "=" * 50)
    print("📈 ANÁLISE TEMPORAL - AGREGAÇÕES")
    print("=" * 50)
    
    # 1. Agregação diária
    print("1. 📊 VENDAS DIÁRIAS:")
    vendas_diarias = df_vendas.groupby(df_vendas['data_venda'].dt.date).agg({
        'valor_total': 'sum',
        'venda_id': 'count',
        'quantidade': 'sum'
    }).rename(columns={'venda_id': 'num_vendas', 'valor_total': 'faturamento_diario'})
    
    print("   Primeiros 5 dias:")
    print(vendas_diarias.head())
    
    # 2. Agregação mensal
    print("\n2. 📅 VENDAS MENSAS:")
    vendas_mensais = df_vendas.groupby(df_vendas['data_venda'].dt.to_period('M')).agg({
        'valor_total': ['sum', 'mean', 'count'],
        'quantidade': 'sum'
    })
    
    vendas_mensais.columns = ['faturamento_total', 'ticket_medio', 'num_vendas', 'total_itens']
    print("   Vendas por mês:")
    print(vendas_mensais)
    
    # 3. Agregação por dia da semana
    print("\n3. 📆 VENDAS POR DIA DA SEMANA:")
    
    # Ordem correta dos dias
    ordem_dias = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
    
    vendas_dia_semana = df_vendas.groupby('nome_dia_semana').agg({
        'valor_total': ['sum', 'mean', 'count'],
        'quantidade': 'mean'
    }).reindex(ordem_dias)
    
    vendas_dia_semana.columns = ['faturamento_total', 'ticket_medio', 'num_vendas', 'media_itens']
    print("   Performance por dia da semana:")
    print(vendas_dia_semana)
    
    # 4. Agregação por categoria e mês
    print("\n4. 🏷️ VENDAS POR CATEGORIA E MÊS:")
    vendas_categoria_mes = df_vendas.groupby([
        df_vendas['data_venda'].dt.to_period('M'), 
        'categoria'
    ]).agg({
        'valor_total': 'sum',
        'venda_id': 'count'
    }).rename(columns={'venda_id': 'num_vendas'})
    
    print("   Vendas por categoria e mês:")
    print(vendas_categoria_mes.head(10))
    
    return vendas_diarias, vendas_mensais, vendas_dia_semana

def analise_tendencias_sazonais(vendas_diarias):
    """Análise de tendências e sazonalidade"""
    
    print("\n" + "=" * 50)
    print("📈 ANÁLISE DE TENDÊNCIAS E SAZONALIDADE")
    print("=" * 50)
    
    # 1. Estatísticas móveis
    print("1. 📊 ESTATÍSTICAS MÓVEIS:")
    vendas_diarias['media_movel_7d'] = vendas_diarias['faturamento_diario'].rolling(window=7).mean()
    vendas_diarias['media_movel_30d'] = vendas_diarias['faturamento_diario'].rolling(window=30).mean()
    
    print("   Estatísticas móveis calculadas:")
    print(vendas_diarias[['faturamento_diario', 'media_movel_7d', 'media_movel_30d']].tail(10))
    
    # 2. Crescimento diário
    print("\n2. 📈 CRESCIMENTO DIÁRIO:")
    vendas_diarias['crescimento_diario'] = vendas_diarias['faturamento_diario'].pct_change() * 100
    vendas_diarias['crescimento_7d'] = vendas_diarias['faturamento_diario'].pct_change(periods=7) * 100
    
    print("   Métricas de crescimento:")
    print(vendas_diarias[['faturamento_diario', 'crescimento_diario', 'crescimento_7d']].tail(10))
    
    # 3. Identificar melhores e piores dias
    print("\n3. 🏆 MELHORES E PIORES DIAS:")
    
    melhor_dia = vendas_diarias.loc[vendas_diarias['faturamento_diario'].idxmax()]
    pior_dia = vendas_diarias.loc[vendas_diarias['faturamento_diario'].idxmin()]
    
    print(f"   Melhor dia: {melhor_dia.name} - R$ {melhor_dia['faturamento_diario']:.2f}")
    print(f"   Pior dia: {pior_dia.name} - R$ {pior_dia['faturamento_diario']:.2f}")
    
    # 4. Dias acima da média
    media_faturamento = vendas_diarias['faturamento_diario'].mean()
    dias_acima_media = vendas_diarias[vendas_diarias['faturamento_diario'] > media_faturamento]
    
    print(f"\n4. 📊 DIAS ACIMA DA MÉDIA:")
    print(f"   Média de faturamento: R$ {media_faturamento:.2f}")
    print(f"   Dias acima da média: {len(dias_acima_media)} de {len(vendas_diarias)} ({len(dias_acima_media)/len(vendas_diarias)*100:.1f}%)")

def analise_comparativa_periodos(df_vendas):
    """Análise comparativa entre diferentes períodos"""
    
    print("\n" + "=" * 50)
    print("🔄 ANÁLISE COMPARATIVA ENTRE PERÍODOS")
    print("=" * 50)
    
    # 1. Comparar meses
    print("1. 📅 COMPARAÇÃO ENTRE MESES:")
    
    # Agrupar por mês
    df_vendas['mes_ano'] = df_vendas['data_venda'].dt.to_period('M')
    comparativo_mensal = df_vendas.groupby('mes_ano').agg({
        'valor_total': ['sum', 'count', 'mean'],
        'quantidade': 'sum'
    })
    
    comparativo_mensal.columns = ['faturamento_total', 'num_vendas', 'ticket_medio', 'total_itens']
    
    # Calcular crescimento mensal
    comparativo_mensal['crescimento_faturamento'] = comparativo_mensal['faturamento_total'].pct_change() * 100
    comparativo_mensal['crescimento_vendas'] = comparativo_mensal['num_vendas'].pct_change() * 100
    
    print("   Comparativo mensal:")
    print(comparativo_mensal)
    
    # 2. Comparar semanas
    print("\n2. 📊 COMPARAÇÃO ENTRE SEMANAS:")
    
    df_vendas['semana_ano'] = df_vendas['data_venda'].dt.isocalendar().week
    comparativo_semanal = df_vendas.groupby('semana_ano').agg({
        'valor_total': 'sum',
        'venda_id': 'count'
    }).rename(columns={'venda_id': 'num_vendas'})
    
    print("   Top 5 semanas por faturamento:")
    print(comparativo_semanal.nlargest(5, 'valor_total'))
    
    # 3. Análise de sazonalidade semanal
    print("\n3. 📈 SAZONALIDADE SEMANAL:")
    
    # Agrupar por dia da semana e calcular estatísticas
    sazonalidade_semanal = df_vendas.groupby('nome_dia_semana').agg({
        'valor_total': ['sum', 'mean', 'count', 'std'],
        'quantidade': 'mean'
    })
    
    sazonalidade_semanal.columns = ['total_dia', 'media_dia', 'vendas_dia', 'desvio_padrao', 'itens_medio']
    ordem_dias = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
    sazonalidade_semanal = sazonalidade_semanal.reindex(ordem_dias)
    
    print("   Padrão semanal de vendas:")
    print(sazonalidade_semanal)

def series_temporais_avancado(df_vendas):
    """Técnicas avançadas de séries temporais"""
    
    print("\n" + "=" * 50)
    print("⏰ TÉCNICAS AVANÇADAS - SÉRIES TEMPORAIS")
    print("=" * 50)
    
    # 1. Preparar dados para série temporal
    print("1. 📊 PREPARANDO DADOS PARA SÉRIE TEMPORAL:")
    
    # Criar série temporal diária
    serie_temporal = df_vendas.groupby(df_vendas['data_venda'].dt.date)['valor_total'].sum()
    serie_temporal = serie_temporal.asfreq('D', fill_value=0)  # Garantir todos os dias
    
    print(f"   Série temporal criada: {len(serie_temporal)} dias")
    print("   Primeiros 10 dias:")
    print(serie_temporal.head(10))
    
    # 2. Decomposição básica de tendência e sazonalidade
    print("\n2. 🔍 DECOMPOSIÇÃO DE TENDÊNCIA E SAZONALIDADE:")
    
    # Usando rolling statistics para tendência
    tendencia = serie_temporal.rolling(window=7, center=True).mean()
    
    # Sazonalidade semanal (média por dia da semana)
    df_temp = pd.DataFrame({'valor': serie_temporal, 'dia_semana': serie_temporal.index.weekday})
    sazonalidade = df_temp.groupby('dia_semana')['valor'].mean()
    
    print("   Tendência (média móvel 7 dias):")
    print(tendencia.tail(10))
    
    print("\n   Padrão sazonal (média por dia da semana):")
    dias = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom']
    for i, valor in enumerate(sazonalidade):
        print(f"   {dias[i]}: R$ {valor:.2f}")
    
    # 3. Detecção de outliers
    print("\n3. 🚨 DETECÇÃO DE OUTLIERS:")
    
    # Calcular z-score
    from scipy import stats
    z_scores = np.abs(stats.zscore(serie_temporal))
    outliers = serie_temporal[z_scores > 2]
    
    print(f"   Possíveis outliers detectados: {len(outliers)} dias")
    if len(outliers) > 0:
        print("   Dias com vendas atípicas:")
        for data, valor in outliers.items():
            print(f"   {data}: R$ {valor:.2f}")
    
    return serie_temporal, tendencia, sazonalidade

def relatorio_analise_temporal(df_vendas, vendas_mensais, vendas_dia_semana):
    """Gera relatório consolidado da análise temporal"""
    
    print("\n" + "=" * 50)
    print("📋 RELATÓRIO DE ANÁLISE TEMPORAL")
    print("=" * 50)
    
    # Métricas gerais
    total_vendas = len(df_vendas)
    faturamento_total = df_vendas['valor_total'].sum()
    periodo_dias = (df_vendas['data_venda'].max() - df_vendas['data_venda'].min()).days
    
    print("📊 MÉTRICAS GERAIS:")
    print(f"   • Período analisado: {periodo_dias} dias")
    print(f"   • Total de vendas: {total_vendas}")
    print(f"   • Faturamento total: R$ {faturamento_total:,.2f}")
    print(f"   • Ticket médio: R$ {df_vendas['valor_total'].mean():.2f}")
    print(f"   • Vendas por dia: {total_vendas/periodo_dias:.1f}")
    
    # Melhor mês
    melhor_mes = vendas_mensais.loc[vendas_mensais['faturamento_total'].idxmax()]
    print(f"\n🎯 MELHOR MÊS: {melhor_mes.name}")
    print(f"   • Faturamento: R$ {melhor_mes['faturamento_total']:,.2f}")
    print(f"   • Vendas: {melhor_mes['num_vendas']}")
    print(f"   • Ticket médio: R$ {melhor_mes['ticket_medio']:.2f}")
    
    # Melhor dia da semana
    melhor_dia = vendas_dia_semana.loc[vendas_dia_semana['faturamento_total'].idxmax()]
    print(f"\n📈 MELHOR DIA DA SEMANA: {vendas_dia_semana['faturamento_total'].idxmax()}")
    print(f"   • Faturamento médio: R$ {melhor_dia['faturamento_total']:,.2f}")
    print(f"   • Vendas médias: {melhor_dia['num_vendas']:.1f}")
    
    # Insights
    print("\n💡 INSIGHTS:")
    
    # Variação entre melhor e pior dia
    melhor_dia_valor = vendas_dia_semana['faturamento_total'].max()
    pior_dia_valor = vendas_dia_semana['faturamento_total'].min()
    variacao = ((melhor_dia_valor - pior_dia_valor) / pior_dia_valor) * 100
    
    print(f"   • Variação entre melhor e pior dia: {variacao:.1f}%")
    print(f"   • Dias de semana vs fim de semana: {vendas_dia_semana.loc[['Monday','Tuesday','Wednesday','Thursday','Friday'], 'faturamento_total'].sum() / vendas_dia_semana.loc[['Saturday','Sunday'], 'faturamento_total'].sum():.1f}x mais vendas")
    
    # Recomendações
    print("\n🎯 RECOMENDAÇÕES:")
    melhor_dia_nome = vendas_dia_semana['faturamento_total'].idxmax()
    pior_dia_nome = vendas_dia_semana['faturamento_total'].idxmin()
    
    print(f"   1. Focar promoções nos dias de {pior_dia_nome} para equilibrar vendas")
    print(f"   2. Aumentar estoque para {melhor_dia_nome} (dia de pico)")
    print("   3. Monitorar tendência mensal para planejamento de estoque")

def main():
    """Função principal"""
    print("🚀 ANÁLISE TEMPORAL COM PANDAS")
    print("=" * 60)
    
    # 1. Criar dados temporais
    df_vendas = criar_dados_temporais()
    
    # 2. Trabalhar com datas
    df_vendas = trabalhar_com_datas(df_vendas)
    
    # 3. Análise de agregação temporal
    vendas_diarias, vendas_mensais, vendas_dia_semana = analise_agregacao_temporal(df_vendas)
    
    # 4. Análise de tendências e sazonalidade
    analise_tendencias_sazonais(vendas_diarias)
    
    # 5. Análise comparativa entre períodos
    analise_comparativa_periodos(df_vendas)
    
    # 6. Técnicas avançadas de séries temporais
    serie_temporal, tendencia, sazonalidade = series_temporais_avancado(df_vendas)
    
    # 7. Relatório final
    relatorio_analise_temporal(df_vendas, vendas_mensais, vendas_dia_semana)
    
    print("\n" + "=" * 60)
    print("✅ ANÁLISE TEMPORAL DOMINADA!")
    print("🎯 PRÓXIMO: Limpeza e preparação de dados")
    print("=" * 60)

if __name__ == "__main__":
    main()