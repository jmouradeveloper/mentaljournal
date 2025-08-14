# Mental Journal - Rails App

Uma aplicação Rails monolítica configurada para rodar exclusivamente em Docker com SQLite.

## Requisitos

- Docker
- Docker Compose

## Como executar

### Primeira execução

1. **Construir e iniciar a aplicação:**
   ```bash
   docker-compose up --build
   ```

   Na primeira execução, o container irá:
   - Criar um novo projeto Rails
   - Instalar as dependências
   - Configurar o banco de dados SQLite
   - Iniciar o servidor

2. **Acessar a aplicação:**
   ```
   http://localhost:3000
   ```

### Execuções subsequentes

```bash
docker-compose up
```

### Comandos úteis

#### Executar comandos Rails
```bash
# Console Rails
docker-compose run --rm rails bundle exec rails console

# Migrations
docker-compose run --rm rails bundle exec rails db:migrate

# Gerar um controller
docker-compose run --rm rails bundle exec rails generate controller Home index

# Gerar um model
docker-compose run --rm rails bundle exec rails generate model User name:string email:string

# Executar testes
docker-compose run --rm rails bundle exec rails test
```

#### Gerenciar containers
```bash
# Parar os containers
docker-compose down

# Reconstruir a imagem
docker-compose build

# Ver logs
docker-compose logs -f web
```

#### Acessar o container
```bash
# Abrir um bash no container
docker-compose exec web bash
```

## Estrutura do Projeto

- **Dockerfile**: Configuração da imagem Docker com Ruby 3.3.0 e Rails 7.1.3
- **docker-compose.yml**: Orquestração dos serviços
- **entrypoint.sh**: Script de inicialização que cria o projeto Rails na primeira execução
- **.dockerignore**: Arquivos a serem ignorados pelo Docker

## Banco de Dados

O projeto usa SQLite tanto para desenvolvimento quanto para produção. O arquivo do banco fica em `db/development.sqlite3` e é persistido através de volume Docker.

## Desenvolvimento

O código fonte é montado como volume no container, então qualquer alteração nos arquivos será refletida automaticamente na aplicação (com hot reload do Rails).

## Produção

Para produção, você pode criar um arquivo `docker-compose.prod.yml` com configurações específicas:

```yaml
version: '3.8'

services:
  web:
    build: .
    ports:
      - "80:3000"
    environment:
      - RAILS_ENV=production
      - SECRET_KEY_BASE=your_secret_key_here
    volumes:
      - ./db:/app/db  # Persistir apenas o banco
```

E executar com:
```bash
docker-compose -f docker-compose.prod.yml up --build
```
