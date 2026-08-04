.PHONY: all build up down stop start clean fclean re status logs

all: up

build:
	@docker-compose build base go-server caddy
	@docker-compose build frontend memoir-3167

up: build
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

KNOWN_TARGETS := all up down stop start clean fclean re status logs

SERVICES := $(filter-out $(KNOWN_TARGETS),$(MAKECMDGOALS))

status:
	@docker-compose ps $(SERVICES)

logs:
	@docker-compose logs -f --tail=200 $(SERVICES)

# No-op so extra words don't become "missing targets"
%:
	@:
