# Makefile for InceptionGit project


.PHONY: up down build clean

# Build and start the containers
up:
	mkdir -p /home/eperperi/database
	mkdir -p /home/eperperi/web
	/requirements/docker-compose up  --build

# Stop and remove the containers
down:
	/requirements/docker-compose down

# Build the Docker images
build:
	/requirements/docker-compose build

# Clean up unused Docker images and volumes
clean:
	docker system prune -f
	docker volume prune -f