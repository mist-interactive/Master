.PHONY: all build up down stop start clean fclean re status logs

COMPOSE = docker compose \
		-f docker-compose.yml \
		-f backend/docker-compose.yml \

all: build

build:
	@$(COMPOSE) build

up:
	@$(COMPOSE) up -d

down:
	@$(COMPOSE) down --remove-orphans

stop:
	@$(COMPOSE) stop

start:
	@$(COMPOSE) start

clean:
	@$(COMPOSE) down --remove-orphans

fclean: clean
	@$(COMPOSE) down -v --rmi all --remove-orphans

re: down clean all

KNOWN_TARGETS := all up down stop start clean fclean re status logs

SERVICES := $(filter-out $(KNOWN_TARGETS),$(MAKECMDGOALS))

status:
	@$(COMPOSE) ps $(SERVICES)

logs:
	@$(COMPOSE) logs -f --tail=200 $(SERVICES)

# No-op so extra words don't become "missing targets"
%:
	@:
