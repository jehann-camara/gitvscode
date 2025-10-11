"""
📊 [04] Pandas - Limpeza e Preparação de Dados
Mês 2: Programação & Bancos - Aula 4

Objetivos:
- Identificar e tratar dados inconsistentes
- Lidar com valores duplicados e outliers
- Padronizar e transformar dados
- Preparar dados para análise
"""

import pandas as pd
import numpy as np
from datetime import datetime
import re

def criar_dados_sujos():
    """Cria dataset com problemas comuns de qualidade de dados"""
    
    print("🧹 CRIANDO DATASET COM DADOS 'SUJOS'")
    print("=" * 50)
    
    np.random.seed(42)
    
    dados = []
    for i in range(1000):
        # Dados com problemas intencionais
        dados.append({
            'id': i + 1,
            'nome': np.random.choice([
                'João Silva', 'MARIA Santos', 'pedro oliveira', 'Ana COSTA', 
                'JOSÉ Pereira', 'Luisa mendes', 'CARLOS Almeida', 'fernanda lima',
                'João Silva', None, '   '  # Duplicados e vazios
            ]),
            'email': np.random.choice([
                'joao@email.com', 'MARIA@email.com', 'pedro@email', 'ana@email.com',
                'jose@email.com', 'luisa@email.com', 'carlos@email', 'fernanda@email.com',
                'joao@email.com', 'invalido', None  # Duplicados e inválidos
            ]),
            'idade': np.random.choice([
                np.random.randint(18, 70), 
                -1,  # Idade negativa
                150,  # Idade impossível
                np.nan  # Valor faltante
            ], p=[0.85, 0.05, 0.05, 0.05]),
            'salario': np.random.choice([
                np.random.normal(3000, 1000),
                -500,  # Salário negativo
                1000000,  # Outlier
                np.nan
            ], p=[0.8, 0.05, 0.05, 0.1]),
            'cidade': np.random.choice([
                'São Paulo', 'sao paulo', 'S.Paulo', 'SP',
                'Rio de Janeiro', 'RIO', 'Rio',
                'Belo Horizonte', 'bh', 'B.H.',
                'Curitiba', 'curitiba', 'CTBA',
                None, '   '
            ]),
            'data_cadastro': np.random.choice([
                '2024-01-15', '15/01/2024', '2024-01-15 10:30:00',
                '01/15/2024', '15-01-2024', '2024/01/15',
                'data_invalida', None
            ]),
            'telefone': np.random.choice([
                '(11) 99999-9999', '11999999999', '11-99999-9999',
                '(11) 9999-9999', '99999-9999', 'telefone',
                None, '   '
            ])
        })
    
    df = pd.DataFrame(dados)
    
    print("📋 Dataset inicial (primeiras 10 linhas):")
    print(df.head(10))
    print(f"\n📊 Dimensões: {df.shape}")
    
    return df

def analise_qualidade_dados(df):
    """Análise completa da qualidade dos dados"""
    
    print("\n" + "=" * 50)
    print"🔍 ANÁLISE DE QUALIDADE DOS DADOS")
    print("=" * 50)
    
    # 1. Informações gerais
    print("1. 📊 INFORMAÇÕES GERAIS:")
    print(f"   Total de registros: {len(df)}")
    print(f"   Total de colunas: {len(df.columns)}")
    print(f"   Uso de memória: {df.memory_usage(deep=True).sum() / 1024**2:.2f} MB")
    
    # 2. Valores faltantes
    print("\n2. ❌ VALORES FALTANTES:")
    missing_data = df.isnull().sum()
    missing_percent = (missing_data / len(df)) * 100
    
    missing_info = pd.DataFrame({
        'Coluna': df.columns,
        'Faltantes': missing_data.values,
        'Percentual': missing_percent.values
    })
    
    print(missing_info)
    
    # 3. Tipos de dados
    print("\n3. 🔧 TIPOS DE DADOS:")
    print(df.dtypes)
    
    # 4. Estatísticas descritivas
    print("\n4. 📈 ESTATÍSTICAS DESCRITIVAS (colunas numéricas):")
    print(df[['idade', 'salario']].describe())
    
    # 5. Valores únicos por coluna
    print("\n5. 🎯 VALORES ÚNICOS POR COLUNA:")
    for coluna in df.columns:
        if df[coluna].dtype == 'object':
            unique_count = df[coluna].nunique()
            print(f"   {coluna}: {unique_count} valores únicos")
    
    return missing_info

def limpeza_valores_faltantes(df, missing_info):
    """Estratégias para lidar com valores faltantes"""
    
    print("\n" + "=" * 50)
    print"🧹 LIMPEZA DE VALORES FALTANTES")
    print("=" * 50)
    
    df_limpo = df.copy()
    
    # Estratégias diferentes por coluna
    estrategias = {
        'nome': 'preencher_placeholder',
        'email': 'preencher_placeholder', 
        'idade': 'preencher_media',
        'salario': 'preencher_media',
        'cidade': 'preencher_moda',
        'data_cadastro': 'preencher_placeholder',
        'telefone': 'preencher_placeholder'
    }
    
    for coluna, estrategia in estrategias.items():
        if missing_info[missing_info['Coluna'] == coluna]['Faltantes'].values[0] > 0:
            if estrategia == 'preencher_media':
                media = df_limpo[coluna].mean()
                df_limpo[coluna].fillna(media, inplace=True)
                print(f"   ✅ {coluna}: preenchido com média ({media:.2f})")
                
            elif estrategia == 'preencher_moda':
                moda = df_limpo[coluna].mode()[0] if not df_limpo[coluna].mode().empty else 'Não Informado'
                df_limpo[coluna].fillna(moda, inplace=True)
                print(f"   ✅ {coluna}: preenchido com moda ({moda})")
                
            elif estrategia == 'preencher_placeholder':
                df_limpo[coluna].fillna('Não Informado', inplace=True)
                print(f"   ✅ {coluna}: preenchido com 'Não Informado'")
    
    print(f"\n📊 Valores faltantes após limpeza: {df_limpo.isnull().sum().sum()}")
    
    return df_limpo

def tratar_valores_duplicados(df_limpo):
    """Identificar e tratar valores duplicados"""
    
    print("\n" + "=" * 50)
    print"🔍 TRATAMENTO DE VALORES DUPLICADOS")
    print("=" * 50)
    
    # 1. Duplicados exatos
    duplicados_exatos = df_limpo.duplicated().sum()
    print(f"1. 🔄 DUPLICADOS EXATOS: {duplicados_exatos}")
    
    if duplicados_exatos > 0:
        print("   Registros duplicados exatos:")
        print(df_limpo[df_limpo.duplicated()].head())
    
    # 2. Duplicados em colunas chave
    duplicados_email = df_limpo.duplicated(subset=['email']).sum()
    duplicados_nome = df_limpo.duplicated(subset=['nome']).sum()
    
    print(f"\n2. 📧 DUPLICADOS POR EMAIL: {duplicados_email}")
    print(f"   👤 DUPLICADOS POR NOME: {duplicados_nome}")
    
    # 3. Remover duplicados
    df_sem_duplicados = df_limpo.drop_duplicates()
    print(f"\n3. 🗑️  REMOÇÃO DE DUPLICADOS:")
    print(f"   Registros antes: {len(df_limpo)}")
    print(f"   Registros depois: {len(df_sem_duplicados)}")
    print(f"   Registros removidos: {len(df_limpo) - len(df_sem_duplicados)}")
    
    return df_sem_duplicados

def padronizar_dados_texto(df):
    """Padroniza dados de texto (maiúsculas, acentos, etc)"""
    
    print("\n" + "=" * 50)
    print"🔠 PADRONIZAÇÃO DE DADOS DE TEXTO")
    print("=" * 50)
    
    df_padronizado = df.copy()
    
    # 1. Nomes - Title Case
    print("1. 👤 PADRONIZANDO NOMES:")
    df_padronizado['nome'] = df_padronizado['nome'].str.title()
    df_padronizado['nome'] = df_padronizado['nome'].str.strip()
    print("   Nomes padronizados (primeiros 5):")
    print(df_padronizado['nome'].head())
    
    # 2. Emails - Minúsculas
    print("\n2. 📧 PADRONIZANDO EMAILS:")
    df_padronizado['email'] = df_padronizado['email'].str.lower()
    df_padronizado['email'] = df_padronizado['email'].str.strip()
    print("   Emails padronizados (primeiros 5):")
    print(df_padronizado['email'].head())
    
    # 3. Cidades - Padronização customizada
    print("\n3. 🏙️ PADRONIZANDO CIDADE:")
    
    mapeamento_cidades = {
        'sao paulo': 'São Paulo', 'S.Paulo': 'São Paulo', 'SP': 'São Paulo',
        'rio de janeiro': 'Rio de Janeiro', 'RIO': 'Rio de Janeiro', 'Rio': 'Rio de Janeiro', 
        'belo horizonte': 'Belo Horizonte', 'bh': 'Belo Horizonte', 'B.H.': 'Belo Horizonte',
        'curitiba': 'Curitiba', 'ctba': 'Curitiba'
    }
    
    df_padronizado['cidade'] = df_padronizado['cidade'].replace(mapeamento_cidades)
    df_padronizado['cidade'] = df_padronizado['cidade'].str.title()
    
    print("   Cidades padronizadas:")
    print(df_padronizado['cidade'].value_counts().head())
    
    return df_padronizado

def validar_dados_numericos(df):
    """Valida e corrige dados numéricos"""
    
    print("\n" + "=" * 50)
    print"🔢 VALIDAÇÃO DE DADOS NUMÉRICOS")
    print("=" * 50)
    
    df_validado = df.copy()
    
    # 1. Validação de idade
    print("1. 🎂 VALIDANDO IDADE:")
    idade_invalida = df_validado[(df_validado['idade'] < 18) | (df_validado['idade'] > 100)]
    print(f"   Idades inválidas encontradas: {len(idade_invalida)}")
    
    # Corrigir idades inválidas
    media_idade = df_validado[(df_validado['idade'] >= 18) & (df_validado['idade'] <= 100)]['idade'].mean()
    df_validado['idade'] = df_validado['idade'].apply(
        lambda x: media_idade if x < 18 or x > 100 else x
    )
    print(f"   Idades corrigidas com média: {media_idade:.1f}")
    
    # 2. Validação de salário
    print("\n2. 💰 VALIDANDO SALÁRIO:")
    salario_invalido = df_validado[(df_validado['salario'] < 0) | (df_validado['salario'] > 50000)]
    print(f"   Salários inválidos encontrados: {len(salario_invalido)}")
    
    # Corrigir salários inválidos
    from scipy import stats
    salarios_validos = df_validado[(df_validado['salario'] >= 0) & (df_validado['salario'] <= 50000)]['salario']
    
    # Remover outliers usando IQR
    Q1 = salarios_validos.quantile(0.25)
    Q3 = salarios_validos.quantile(0.75)
    IQR = Q3 - Q1
    limite_inferior = Q1 - 1.5 * IQR
    limite_superior = Q3 + 1.5 * IQR
    
    media_salario = salarios_validos[
        (salarios_validos >= limite_inferior) & (salarios_validos <= limite_superior)
    ].mean()
    
    df_validado['salario'] = df_validado['salario'].apply(
        lambda x: media_salario if x < 0 or x > 50000 or 
        (x < limite_inferior or x > limite_superior) else x
    )
    
    print(f"   Salários corrigidos. Média utilizada: R$ {media_salario:.2f}")
    
    return df_validado

def padronizar_formatos_dados(df):
    """Padroniza formatos de dados específicos"""
    
    print("\n" + "=" * 50)
    print"📝 PADRONIZAÇÃO DE FORMATOS")
    print("=" * 50)
    
    df_formatado = df.copy()
    
    # 1. Padronizar datas
    print("1. 📅 PADRONIZANDO DATAS:")
    
    def parse_data(data):
        if pd.isna(data) or data in ['Não Informado', 'data_invalida']:
            return None
        
        try:
            # Tentar diferentes formatos
            for fmt in ['%Y-%m-%d', '%d/%m/%Y', '%Y-%m-%d %H:%M:%S', '%m/%d/%Y', '%d-%m-%Y', '%Y/%m/%d']:
                try:
                    return datetime.strptime(str(data), fmt).date()
                except ValueError:
                    continue
            return None
        except:
            return None
    
    df_formatado['data_cadastro'] = df_formatado['data_cadastro'].apply(parse_data)
    datas_validas = df_formatado['data_cadastro'].notna().sum()
    print(f"   Datas validadas: {datas_validas}/{len(df_formatado)}")
    
    # 2. Padronizar telefones
    print("\n2. 📞 PADRONIZANDO TELEFONES:")
    
    def formatar_telefone(tel):
        if pd.isna(tel) or tel in ['Não Informado', 'telefone']:
            return 'Não Informado'
        
        # Manter apenas números
        numeros = re.sub(r'\D', '', str(tel))
        
        if len(numeros) == 11:  # Com DDD
            return f"({numeros[:2]}) {numeros[2:7]}-{numeros[7:]}"
        elif len(numeros) == 10:  # Formato antigo
            return f"({numeros[:2]}) {numeros[2:6]}-{numeros[6:]}"
        else:
            return 'Inválido'
    
    df_formatado['telefone'] = df_formatado['telefone'].apply(formatar_telefone)
    print("   Telefones formatados (primeiros 5):")
    print(df_formatado['telefone'].head())
    
    # 3. Validar emails
    print("\n3. 📧 VALIDANDO EMAILS:")
    
    def validar_email(email):
        if email == 'Não Informado' or pd.isna(email):
            return False
        
        padrao = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
        return bool(re.match(padrao, email))
    
    df_formatado['email_valido'] = df_formatado['email'].apply(validar_email)
    emails_validos = df_formatado['email_valido'].sum()
    print(f"   Emails válidos: {emails_validos}/{len(df_formatado)} ({emails_validos/len(df_formatado)*100:.1f}%)")
    
    return df_formatado

def criar_metricas_qualidade(df_original, df_final):
    """Cria métricas de qualidade dos dados"""
    
    print("\n" + "=" * 50)
    print"📊 MÉTRICAS DE QUALIDADE DOS DADOS")
    print("=" * 50)
    
    print("📋 COMPARAÇÃO ANTES E DEPOIS DA LIMPEZA:")
    print(f"   {'Métrica':<20} {'Antes':<10} {'Depois':<10} {'Melhoria':<10}")
    print("-" * 60)
    
    metricas = []
    
    # 1. Valores faltantes
    faltantes_antes = df_original.isnull().sum().sum()
    faltantes_depois = df_final.isnull().sum().sum()
    metricas.append(('Valores Faltantes', faltantes_antes, faltantes_depois))
    
    # 2. Duplicados
    duplicados_antes = df_original.duplicated().sum()
    duplicados_depois = df_final.duplicated().sum()
    metricas.append(('Registros Duplicados', duplicados_antes, duplicados_depois))
    
    # 3. Dados inconsistentes (exemplo com idade)
    idade_invalida_antes = len(df_original[(df_original['idade'] < 18) | (df_original['idade'] > 100)])
    idade_invalida_depois = len(df_final[(df_final['idade'] < 18) | (df_final['idade'] > 100)])
    metricas.append(('Idades Inválidas', idade_invalida_antes, idade_invalida_depois))
    
    # 4. Emails válidos
    def contar_emails_validos(df):
        padrao = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
        return df['email'].apply(lambda x: bool(re.match(padrao, str(x))) if pd.notna(x) else False).sum()
    
    emails_validos_antes = contar_emails_validos(df_original)
    emails_validos_depois = contar_emails_validos(df_final)
    metricas.append(('Emails Válidos', emails_validos_antes, emails_validos_depois))
    
    # Mostrar métricas
    for nome, antes, depois in metricas:
        melhoria = antes - depois if nome != 'Emails Válidos' else depois - antes
        sinal = '+' if nome == 'Emails Válidos' else '-'
        print(f"   {nome:<20} {antes:<10} {depois:<10} {sinal}{abs(melhoria)}")
    
    # Score de qualidade
    qualidade_antes = (1 - (faltantes_antes + duplicados_antes + idade_invalida_antes) / 
                      (len(df_original) * 3)) * 100
    qualidade_depois = (1 - (faltantes_depois + duplicados_depois + idade_invalida_depois) / 
                       (len(df_final) * 3)) * 100
    
    print(f"\n🎯 SCORE DE QUALIDADE:")
    print(f"   Antes da limpeza: {qualidade_antes:.1f}%")
    print(f"   Depois da limpeza: {qualidade_depois:.1f}%")
    print(f"   Melhoria: +{qualidade_depois - qualidade_antes:.1f}%")

def pipeline_limpeza_completa():
    """Pipeline completo de limpeza de dados"""
    
    print("🚀 INICIANDO PIPELINE COMPLETO DE LIMPEZA")
    print("=" * 60)
    
    # 1. Criar dados sujos
    df_original = criar_dados_sujos()
    
    # 2. Análise de qualidade inicial
    missing_info = analise_qualidade_dados(df_original)
    
    # 3. Limpeza de valores faltantes
    df_limpo_faltantes = limpeza_valores_faltantes(df_original, missing_info)
    
    # 4. Tratar duplicados
    df_sem_duplicados = tratar_valores_duplicados(df_limpo_faltantes)
    
    # 5. Padronizar texto
    df_padronizado = padronizar_dados_texto(df_sem_duplicados)
    
    # 6. Validar dados numéricos
    df_validado = validar_dados_numericos(df_padronizado)
    
    # 7. Padronizar formatos
    df_final = padronizar_formatos_dados(df_validado)
    
    # 8. Métricas finais
    criar_metricas_qualidade(df_original, df_final)
    
    print("\n" + "=" * 60)
    print("✅ PIPELINE DE LIMPEZA CONCLUÍDO!")
    print("📊 Dataset final (primeiras 5 linhas):")
    print(df_final.head())
    print(f"\n🎯 PRÓXIMO: Visualização de dados")
    print("=" * 60)
    
    return df_original, df_final

def main():
    """Função principal"""
    df_original, df_final = pipeline_limpeza_completa()

if __name__ == "__main__":
    main()