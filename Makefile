
all: up

up:
	docker-compose -f srcs/docker-compose.yml up --build

build:
	docker-compose -f srcs/docker-compose.yml build

logs:
	docker-compose -f srcs/docker-compose.yml logs -f

prune:
	docker system prune -f

down:
	docker-compose -f srcs/docker-compose.yml down

restart: down up

clean:
	docker-compose -f srcs/docker-compose.yml down -v

help:
	@echo "Makefile for Docker Compose"
	@echo "Available targets:"
	@echo "  up      - Start services"
	@echo "  down    - Stop services"
	@echo "  build   - Build services"
	@echo "  logs    - View logs"
	@echo "  exec    - Execute command in service"
	@echo "  prune   - Remove unused containers and images"
	@echo "  restart  - Restart services"
	@echo "  clean   - Remove volumes and stop services"
	@echo "  help    - Show this help message"

.PHONY: all up down build logs exec prune restart clean help