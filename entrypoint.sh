#!/bin/bash
set -e

# Verifica se é a primeira execução (se não existe Gemfile)
if [ ! -f "Gemfile" ]; then
    echo "Criando novo projeto Rails..."
    rails new . --database=sqlite3 --force --skip-git
    
    # Copia o template do database.yml
    if [ -f "config/database.yml.template" ]; then
        cp config/database.yml.template config/database.yml
        echo "Configuração do banco de dados atualizada para SQLite em todos os ambientes"
    fi
    
    echo "Projeto Rails criado com sucesso!"
fi

# Sempre garantir que as gems estejam instaladas
echo "Verificando e instalando gems..."
bundle check || bundle install

# Verifica se o banco de dados existe
if [ ! -f "db/development.sqlite3" ]; then
    echo "Criando banco de dados..."
    bundle exec rails db:create
    bundle exec rails db:migrate
    echo "Banco de dados criado com sucesso!"
fi

# Remove PID file if exists
rm -f tmp/pids/server.pid

# Executa o comando passado como argumento
exec "$@"
