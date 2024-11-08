
all: up

up: secrets
	mkdir -p ~/data
	mkdir -p ~/data/wordpress
	mkdir -p ~/data/mariadb
	docker-compose -f srcs/docker-compose.yml up --build

build:
	docker-compose -f srcs/docker-compose.yml build

logs:
	docker-compose -f srcs/docker-compose.yml logs -f

prune:
	docker system prune -f

down:
	docker-compose -f srcs/docker-compose.yml down

clean:
	docker-compose -f srcs/docker-compose.yml down -v

fclean: clean
	docker run -it --rm -v $(HOME)/data:/data busybox sh -c "rm -rf data/*"
	docker system prune -af
	docker-compose -f srcs/docker-compose.yml down -v --rmi all

re: fclean up

secrets:
	mkdir -p $@
	openssl rand -hex -out $@/db_root_password.txt 16
	openssl rand -hex -out $@/db_password.txt 16
	openssl rand -hex -out $@/wp_admin_password.txt 16
	openssl rand -hex -out $@/wp_password.txt 16

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