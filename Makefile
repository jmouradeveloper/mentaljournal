.PHONY: build up down logs shell console test clean help

# Comandos principais
build:
	docker compose build

up:
	docker compose up

up-build:
	docker compose up --build

down:
	docker compose down

logs:
	docker compose logs -f web

shell:
	docker compose exec web bash

console:
	docker compose run --rm rails bundle exec rails console

# Comandos Rails
migrate:
	docker compose run --rm rails bundle exec rails db:migrate

rollback:
	docker compose run --rm rails bundle exec rails db:rollback

seed:
	docker compose run --rm rails bundle exec rails db:seed

routes:
	docker compose run --rm rails bundle exec rails routes

test:
	docker compose run --rm rails bundle exec rails test

# Geradores Rails
generate-controller:
	@read -p "Nome do controller: " name; \
	docker compose run --rm rails bundle exec rails generate controller $$name

generate-model:
	@read -p "Nome do model: " name; \
	@read -p "Atributos (ex: name:string email:string): " attrs; \
	docker compose run --rm rails bundle exec rails generate model $$name $$attrs

generate-migration:
	@read -p "Nome da migration: " name; \
	docker compose run --rm rails bundle exec rails generate migration $$name

# Limpeza
clean:
	docker compose down -v
	docker system prune -f

clean-all:
	docker compose down -v --rmi all
	docker system prune -af

# Ajuda
help:
	@echo "Comandos disponíveis:"
	@echo "  build              - Construir a imagem Docker"
	@echo "  up                 - Iniciar os containers"
	@echo "  up-build           - Construir e iniciar os containers"
	@echo "  down               - Parar os containers"
	@echo "  logs               - Ver logs do container web"
	@echo "  shell              - Abrir bash no container"
	@echo "  console            - Abrir console Rails"
	@echo ""
	@echo "Comandos Rails:"
	@echo "  migrate            - Executar migrations"
	@echo "  rollback           - Fazer rollback da última migration"
	@echo "  seed               - Executar seeds"
	@echo "  routes             - Mostrar rotas"
	@echo "  test               - Executar testes"
	@echo ""
	@echo "Geradores:"
	@echo "  generate-controller - Gerar controller"
	@echo "  generate-model     - Gerar model"
	@echo "  generate-migration - Gerar migration"
	@echo ""
	@echo "Limpeza:"
	@echo "  clean              - Limpar containers e volumes"
	@echo "  clean-all          - Limpar tudo (containers, volumes e imagens)"
