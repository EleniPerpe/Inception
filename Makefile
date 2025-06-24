# Makefile for InceptionGit project
DC_YVM = ./srcs/requirements/docker-compose.yml
DC = docker compose -f $(DC_YVM)

.PHONY: make down logs ps volumes clean re

# Build and start the containers
make:
	mkdir -p /Users/eperperi/data/database
	mkdir -p /Users/eperperi/data/web
	$(DC) build
	$(DC) up  -d

# Stop and remove the containers
down:
	$(DC) down

logs:
	$(DC) logs -f

ps:
	$(DC) ps

volumes:
	docker volume ls

# Clean up unused Docker images and volumes
clean:
	$(DC) down --rmi all --volumes --remove-orphans
	$(DC) kill
	docker system prune -f
	docker volume prune -f
	sudo rm -rf /Users/eperperi/data/database/*
	sudo rm -rf -p /Users/eperperi/data/web/*

re: down clean make
