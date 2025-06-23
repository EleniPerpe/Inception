# Makefile for InceptionGit project
DC_YVM = ./requirements/docker-compose.yml
DC = docker compose -f $(DC_YVM)

.PHONY: up down build clean re

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

# Clean up unused Docker images and volumes
clean:
	docker system prune -f
	docker volume prune -f

re: down clean up
