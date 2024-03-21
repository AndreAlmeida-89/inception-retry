NAME 				= inception

all: up

up:
	@printf "Launch configuration ${NAME}...\n"
	@bash srcs/requirements/tools/create_certificates.sh
	@bash srcs/requirements/tools/create_volume_folders.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d

build:
	@printf "Building configuration ${NAME}...\n"
	@bash srcs/requirements/tools/create_certificates.sh
	@bash srcs/requirements/tools/create_volume_folders.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

down:
	@printf "Stopping configuration ${NAME}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down

re:
	@printf "Rebuild configuration ${NAME}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

clean: down
	@printf "Cleaning configuration ${NAME}...\n"
	@docker system prune -a
	@sudo rm -rf ./data/wordpress/*
	@sudo rm -rf ./data/mariadb/*


#Be careful! Fclean removes all Docker images that are on the machine!
fclean:
	@printf "Total clean of all configurations docker\n"
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf ./data/wordpress/*
	@sudo rm -rf ./data/mariadb/*

.PHONY	: all build down re clean fclean
