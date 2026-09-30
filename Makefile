.PHONY: all build up down stop start clean fclean re status logs env secrets

all: up

build:
	@docker-compose build base go-server caddy
	@docker-compose build frontend memoir-3167

up: secrets env build
	@docker-compose up -d

down:
	@docker-compose down --remove-orphans

stop:
	@docker-compose stop

start:
	@docker-compose start

clean:
	@docker-compose down --remove-orphans

fclean: clean
	@docker-compose down -v --rmi all --remove-orphans

re: down clean all

KNOWN_TARGETS := all up down stop start clean fclean re status logs env secrets

SERVICES := $(filter-out $(KNOWN_TARGETS),$(MAKECMDGOALS))

status:
	@docker-compose ps $(SERVICES)

logs:
	@docker-compose logs -f --tail=200 $(SERVICES)

# No-op so extra words don't become "missing targets"
%:
	@:

SECRETS_DIR := ./secrets

secrets:
	@mkdir -p "$(SECRETS_DIR)"
	@test -f "$(SECRETS_DIR)/postgres_user_pw.txt" || \
		openssl rand -hex 10 > "$(SECRETS_DIR)/postgres_user_pw.txt"
	@test -f "$(SECRETS_DIR)/jwt_private.pem" || \
		openssl genpkey -algorithm RSA -out "$(SECRETS_DIR)/jwt_private.pem" -pkeyopt rsa_keygen_bits:2048
	@test -f "$(SECRETS_DIR)/jwt_public.pem" || \
		openssl rsa -pubout -in "$(SECRETS_DIR)/jwt_private.pem" -out "$(SECRETS_DIR)/jwt_public.pem"
	@test -f "$(SECRETS_DIR)/gameserver_api_key.txt" || \
		openssl rand -hex 32 > "$(SECRETS_DIR)/gameserver_api_key.txt"
	@chmod 600 \
		"$(SECRETS_DIR)/postgres_user_pw.txt" \
		"$(SECRETS_DIR)/jwt_private.pem" \
		"$(SECRETS_DIR)/gameserver_api_key.txt"

env:
	@if [ ! -f .env ]; then \
		if [ -f .env.example ]; then \
			cp .env.example .env; \
			echo "Created .env from .env.example"; \
		else \
			echo "Error: .env.example not found"; \
			exit 1; \
		fi \
	else \
		echo ".env already exists"; \
	fi
