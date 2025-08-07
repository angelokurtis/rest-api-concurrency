ifneq (,$(wildcard ./.env))
	include .env
	export $(shell sed 's/=.*//' .env)
endif

SHELL = /usr/bin/env bash -o pipefail
.SHELLFLAGS = -ec

COMPOSE = docker-compose
COMPOSE_FILE = docker-compose.yml

##@ Help

.PHONY: help
help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Docker Compose

.PHONY: up
up: ## Start Docker Compose in detached mode
	$(COMPOSE) -f $(COMPOSE_FILE) up -d

.PHONY: down
down: ## Stop and remove containers
	$(COMPOSE) -f $(COMPOSE_FILE) down

.PHONY: logs
logs: ## Follow container logs
	$(COMPOSE) -f $(COMPOSE_FILE) logs -f

.PHONY: ps
ps: ## Show status of containers
	$(COMPOSE) -f $(COMPOSE_FILE) ps

.PHONY: restart
restart: down up ## Restart containers

.PHONY: clean
clean: ## Remove containers and volumes
	$(COMPOSE) -f $(COMPOSE_FILE) down -v
