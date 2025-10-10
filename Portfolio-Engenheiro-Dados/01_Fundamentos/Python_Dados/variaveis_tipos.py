"""
📚 Fundamentos Python - Variáveis e Tipos de Dados // By Jehann Câmara
Mês 1: Fundamentos - Aula 1
"""

# ======================
# 1. VARIÁVEIS BÁSICAS
# ======================

# Strings (texto)
nome = "João Silva"
empresa = 'Microsoft'
mensagem = """Esta é uma mensagem
com múltiplas linhas"""

# Números inteiros
idade = 25
quantidade_produtos = 100
ano_atual = 2024

# Números decimais (float)
preco = 29.99
altura = 1.75
temperatura = 23.5

# Booleanos (True/False)
esta_ativado = True
tem_acesso = False

# ======================
# 2. COLEÇÕES DE DADOS
# ======================

# Listas (mutáveis)
frutas = ["maçã", "banana", "laranja"]
numeros = [1, 2, 3, 4, 5]
misturado = [1, "texto", True, 3.14]

# Tuplas (imutáveis)
coordenadas = (10, 20)
cores_rgb = (255, 0, 0)

# Dicionários (chave-valor)
pessoa = {
    "nome": "Maria",
    "idade": 30,
    "cidade": "São Paulo"
}

produto = {
    "id": 1,
    "nome": "Notebook",
    "preco": 2500.00,
    "estoque": True
}

# ======================
# 3. OPERAÇÕES BÁSICAS
# ======================

# Operações matemáticas
a = 10
b = 3

soma = a + b
subtracao = a - b
multiplicacao = a * b
divisao = a / b
divisao_inteira = a // b
resto = a % b
potencia = a ** b

# Operações com strings
nome_completo = nome + " " + empresa
repeticao = "Python " * 3

# ======================
# 4. FUNÇÕES ÚTEIS
# ======================

# Tipo de dados
print(f"Tipo de nome: {type(nome)}")
print(f"Tipo de idade: {type(idade)}")
print(f"Tipo de preco: {type(preco)}")
print(f"Tipo de lista: {type(frutas)}")

# Conversão de tipos
texto_numero = "123"
numero_convertido = int(texto_numero)
decimal_texto = str(3.14)

# ======================
# 5. EXERCÍCIOS PRÁTICOS
# ======================

# Exercício 1: Calcular IMC
peso = 70
altura = 1.75
imc = peso / (altura ** 2)
print(f"IMC calculado: {imc:.2f}")

# Exercício 2: Trabalhando com listas
numeros_pares = [2, 4, 6, 8, 10]
print(f"Primeiro número: {numeros_pares[0]}")
print(f"Último número: {numeros_pares[-1]}")
print(f"Quantidade: {len(numeros_pares)}")

# Exercício 3: Manipulando dicionário
print(f"Nome: {pessoa['nome']}")
print(f"Idade: {pessoa['idade']}")

# Adicionando nova chave
pessoa["profissao"] = "Engenheiro de Dados"
print(f"Profissão: {pessoa['profissao']}")

"""
🎯 DESAFIO:
1. Crie uma variável para armazenar seu nome e idade
2. Crie uma lista com 3 países que você gostaria de visitar
3. Crie um dicionário com informações de um livro
4. Calcule a área de um círculo (raio = 5)
"""