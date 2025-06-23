# Makefile for InceptionGit project
DC_YVM = ./requirements/docker-compose.yml
DC = docker compose -f $(DC_YVM)

.PHONY: up down build logs ps volumes clean re

# Build and start the containers
up:
	mkdir -p /home/eperperi/data/database
	mkdir -p /home/eperperi/data/web
	$(DC) up  --build

# Stop and remove the containers
down:
	$(DC) down

# Build the Docker images
build:
	$(DC) build

logs:
	$(DC) logs -f

ps:
	$(DC) ps

volumes:
	$(DC) volume ls

# Clean up unused Docker images and volumes
clean:
	$(DC) kill
	docker system prune -f
	docker volume prune -f
	sudo rm -rf /home/eperperi/data/database
	sudo rm -rf -p /home/eperperi/data/web

re: down clean up 
