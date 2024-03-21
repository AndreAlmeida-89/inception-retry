name = inception
DATA_PATH = $(HOME)/data
DB_PATH = $(DATA_PATH)/mariadb
WP_PATH = $(DATA_PATH)/wordpress
SSL_PATH = ./srcs/requirements/nginx/tools
CRT_PATH = $(SSL_PATH)/localhost.crt
KEY_PATH = $(SSL_PATH)/localhost.key

all: create_data gen_ssl_cert
	@printf "Launch configuration ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d

build: create_data gen_ssl_cert
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
	@echo "Checking if wordpress data exists..."
	@if [ ! -d $(WP_PATH) ]; then \
		mkdir -p $(WP_PATH); \
	fi
	@echo "Checking if mariadb data exists..."
	@if [ ! -d $(DB_PATH) ]; then \
		mkdir -p $(DB_PATH); \
	fi

clean_data:
	# Cleaning data folders content
	@echo "Cleaning wordpress data..."
	@rm -rf $(WP_PATH)/*
	@echo "Cleaning mariadb data..."
	@rm -rf $(DB_PATH)/*
	# Cleaning SSL certificate
	@echo "Cleaning SSL certificate..."
	@rm -f $(CRT_PATH) $(KEY_PATH)

gen_ssl_cert:
	@echo "Generating SSL certificate..."
	@if [ ! -f $(CRT_PATH) ] || [ ! -f $(KEY_PATH) ]; then \
		openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $(KEY_PATH) -out $(CRT_PATH) -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=42/CN=localhost"; \
	fi

.PHONY	: all build down re clean fclean
