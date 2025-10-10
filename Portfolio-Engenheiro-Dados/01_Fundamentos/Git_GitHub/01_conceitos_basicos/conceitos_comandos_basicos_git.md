
# 📚 O que é Git e GitHub?

## 🎯 Objetivos desta Aula
- Entender o que é Git e como funciona
- Compreender a diferença entre Git e GitHub
- Conhecer os conceitos básicos de versionamento

## 🤔 O que é Git?

**Git** é um sistema de controle de versão distribuído que permite:
- Acompanhar mudanças no código fonte
- Trabalhar em equipe de forma organizada  
- Voltar para versões anteriores do projeto
- Experimentar novas ideias sem medo de "quebrar" o código

### Analogia Simples:
Pense no Git como um **"salvamento inteligente"** do seu projeto. Cada "save" guarda o estado completo e você pode voltar a qualquer ponto.

## 🌐 Git vs GitHub

| Git | GitHub |
|-----|---------|
| Sistema de controle de versão | Plataforma para hospedar repositórios Git |
| Roda na sua máquina | Serviço online |
| Gerencia o histórico | Colaboração e compartilhamento |

**Resumo:** Git é a ferramenta, GitHub é onde você armazena e compartilha seus projetos.

## 🏗️ Conceitos Fundamentais

### 1. Repositório (Repo)
- **Pasta do seu projeto** com controle de versão
- Contém todos os arquivos e histórico de alterações
- Pode ser local (sua máquina) ou remoto (GitHub)

### 2. Commit
- **"Snapshot"** do seu projeto em um momento específico
- Cada commit tem uma mensagem explicando as mudanças
- Exemplo: "Adiciona função de login básica"

### 3. Branch (Ramificação)
- **Linha alternativa** de desenvolvimento
- Permite trabalhar em features sem afetar o código principal
- Padrão: branch `main` ou `master` (versão principal)

### 4. Merge
- **Integração** de branches
- Traz mudanças de uma branch para outra

## 🚀 Fluxo Básico de Trabalho

```bash
1. git init          # Inicializa repositório
2. git add .         # Prepara arquivos para commit
3. git commit -m "mensagem"  # Salva as mudanças
4. git push          # Envia para GitHub (se tiver repo remoto)


# Principais conceitos e comandos Git // By Jehann Câmara.
    Obs: Importante: Atenção ao diretório correto, quando inicializar repositório, tanto via terminal Git Bash ou via Vscode
    OBS: Boas Práticas -- Commits atômicos -- Mensagens claras -- Branch main protegida

# Termos Git:
    Branch (Ramificação,Filial,Galho: criam copias do Main/Master para futuros Merges);
    Checkout (Alternar para Branch ou commit específico);
    Clone (Clonar);
    Commit (Salvamento com Hash e registro);
    Fork (Bifurcação: Cópia de repositório de outro usuário para sua conta Github);
    Features (são características ou funcionalidades específicas que agregam valor a um produto, serviço ou sistema);
    Git (Sistema de controle de versão distribuído e de código aberto);
    GitHub (Plataforma de hospedagem baseada na web: Cloud. Que usa o Git para controle de versão. Oferece ferramentas de colaboração);
    Head (Cabeça: Local/Versão atual do projeto);
    Issue ();
    Main/Master
    Merge
    Pull
    Pull Request:PR
    Push (Envia os commits do reporsitório local, para um repositório remoto no GitHub(Cloud));
    Repository
    Release (Lançamento de versão);
    Stage/Add
    Tag
    
# Boas práticas nos comentários de commits
    feat: nova funcionalidade
    fix: correção de bug
    docs: documentação
    style: formatação
    refactor: refatoração
    test: testes


# Comandos Git no terminal Git Bash ( Windows) 
    dir
    clear
    git help
    git branch
    git branch AddMenu
    git branch -d AddMenu
    git switch 
    git switch -c
    git status
    git add --all
    git add .
    git commit
    git commit -a
    git commit -m "Mensagem ao comitar"
    git commit -m "Alterar último commit com amend" --amend
    git diff
    git restore
    git restore --staged
    git log
    git log --oneline
    git rm
    git mv 
    git reset --hard a47a6f8
    git push --all
    git pull  
    git clone

# Comandos de configuração do Git.
    git config --global user.name "Jehann Câmara" 
    git config --global user.email 	meuEmail@outlook.com
    git config --global init.default branch main **Ou branch master**

# Configurar editor padrão (VS Code)
    git config --global core.editor "code --wait"

# Inicializar diretótio Git, após estar dentro do diretório desejado.( criando um sub-diretório oculto e empty).
    git init

# Tracking dos arquivos no Git.
    git add index.html
    git add image.jpg

# Remover do Tracking (Exemplo).
    git rm --cached index.html

# add todos arquivos do diretório no Tracking. Adicionados, mas não comitados ainda (Staged=preparado - pré commit).
    git add --all
    git add .

# Primeiro Snapshot após commit.
    git commit
    git commit - m "Primeiro commit de todos os arquivos Staged."

# Mostra alterações feitas em arquivos commitados.
    git diff

# Pós versionamento, um arquivo pode estar em 3 status: 
    Working - Staged - Commited

# Verifica o Log de commits  
    git log

# Pulando o Staged - do status: Working para o Commited  
     git commit -a -m "Commit pulando o Staging."

# Remover do Tracking (Exemplo).
    git rm hamburger.jpg

# Restore arquivo em staged.
    git restore --staged hamburger.jpg

# Restore arquivo para status Commited.
    git restore hamburger.jpg

# ATENÇÃO ao executar commit com arquivo deletado, é importante incluir mensagem, para evitar erros!
    git commit -a -m "Commit com arquivo deleted"

# Renomear um arquivo, equivale a "mover para outro nome".
    git mv hamburger.jpg hamburger2.jpg

# Amend = alterar.
    git commit -m "Alterar último commit com amend" --amend

# Log detalhado.
    git log -p

# Os 3 tipos de Git Resets: Mixed( È o Default).
    Soft: O Head(Cabeça), pode ser alterado na Chain(Corrente). Com o status do Head anterior como Staged, pronto para commit.
    Mixed( È o Default): O Head, pode ser alterado na Chain. Com o status do Head anterior como UnStaged, necessitando um Add + commit.
    Hard: O Head, pode ser alterado na Chain. Com o Head anterior como excluido.
        ex: ( git reset --hard a47a6f8 )

# Alias ( atalhos, apelidos) em git, local ou global, ex:
    git config alias.coma "commit -a"
    git config --global alias.sts status
    git config --global alias.com "commit -a"
    git config --global alias.coma "commit -a"
    git config --global alias.log1 "log --oneline"
    
    
# Verifica as Branchs.
    git branch
    
# Adiciona Branch chamada "AddMenu".
    git branch AddMenu

# Mudar para a Branch chamada "AddMenu".
    git switch AddMenu

# Merge da Branch "AddMenu" para a Branch "master".
    git merge -m "Merge da Branch AddMenu para a Branch master" AddMenu

# Exclue a Branch chamada "AddMenu".
    git branch -d AddMenu

# Push (Envia os commits do reporsitório local, para um repositório remoto no GitHub(Cloud));  
    git remote add origin https://github.com/jehann-camara/my-website-treinamento.git

# Push (Envia os commits do reporsitório local, para um repositório remoto no GitHub(Cloud));  
    git push -u origin master

# Realiza o Push (" Empurrar/upload para a cloud do GitHub"), das Branchs,
    git push --all

# Realiza o Pull, o contrário do Push (" Puxar/download") a versão atual do GitHub para a local.
    git pull

# Clocar Repositório
    git clone https://github.com/jehann-camara/gitvscode