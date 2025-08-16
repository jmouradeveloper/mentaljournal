#!/bin/bash
set -e

# Instalar Rails 8 se não estiver disponível
gem list rails | grep -q rails || gem install rails -v "~> 8.0.0"

# Verifica se é a primeira execução (se não existe Gemfile)
if [ ! -f "Gemfile" ]; then
    echo "Criando novo projeto Rails 8..."
    rails new . --database=sqlite3 --force --skip-git --name=mentaljournal --skip-bundle
    
    # Copia o template do database.yml
    if [ -f "config/database.yml.template" ]; then
        cp config/database.yml.template config/database.yml
        echo "Configuração do banco de dados atualizada para SQLite em todos os ambientes"
    fi
    
    echo "Projeto Rails 8 criado com sucesso!"
    echo "Instalando gems com logs visíveis..."
    bundle install --verbose
else
    # Sempre garantir que as gems estejam instaladas
    echo "Verificando e instalando gems..."
    bundle check || bundle install --verbose
fi

# Verifica se o banco de dados existe
if [ -f "bin/rails" ] && [ ! -f "db/development.sqlite3" ]; then
    echo "Criando banco de dados..."
    bundle exec rails db:create
    bundle exec rails db:migrate
    echo "Banco de dados criado com sucesso!"
fi

# Remove PID file if exists
rm -f tmp/pids/server.pid

# Executa o comando passado como argumento ou o comando padrão
if [ $# -eq 0 ]; then
    if [ -f "bin/rails" ]; then
        exec bundle exec rails server -b 0.0.0.0
    else
        echo "Aplicação Rails não encontrada. Execute o container novamente."
        exit 1
    fi
else
    exec "$@"
fi
