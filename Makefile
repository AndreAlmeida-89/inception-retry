name = inception
all: create_data
	@printf "Launch configuration ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d

build: create_data
	@printf "Building configuration ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

down:
	@printf "Stopping configuration ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down

re:
	@printf "Rebuild configuration ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

clean: down clean_data
	@printf "Cleaning configuration ${name}...\n"
	@docker system prune -a

#Be careful! Fclean removes all Docker images that are on the machine!
fclean: clean_data
	@printf "Total clean of all configurations docker\n"
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
# ------------------------------------------------- #
# Tools

# Check if ~/data/wordpress and ~/data/mariadb exist
# if not, create them
create_data:
	@echo "Checking if ~/data/wordpress exists..."
	@if [ ! -d ~/data/wordpress ]; then \
		echo "Creating ~/data/wordpress..."; \
		mkdir -p ~/data/wordpress; \
	fi
	@echo "Checking if ~/data/mariadb exists..."
	@if [ ! -d ~/data/mariadb ]; then \
		echo "Creating ~/data/mariadb..."; \
		mkdir -p ~/data/mariadb; \
	fi

clean_data:
	@echo "Cleaning ~/data/wordpress..."
	@sudo rm -rf ~/data/wordpress/*
	@echo "Cleaning ~/data/mariadb..."
	@sudo rm -rf ~/data/mariadb/*
	@docker volume rm $(docker volume ls -q)

#ma

.PHONY	: all build down re clean fclean
