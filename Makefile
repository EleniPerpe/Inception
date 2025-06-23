# Makefile for InceptionGit project


.PHONY: up down build clean

# Build and start the containers
up:
	mkdir -p /home/eperperi/database
	mkdir -p /home/eperperi/web
	docker-compose up  --build

# Stop and remove the containers
down:
	docker-compose down

# Build the Docker images
build:
	docker-compose build

# Clean up unused Docker images and volumes
clean:
	docker system prune -f
	docker volume prune -f