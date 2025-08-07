# Load environment variables from .env file if present
ifneq (,$(wildcard .env))
	include .env
	export $(shell grep -v '^#' .env | sed '/^\s*$$/d' | sed 's/=.*//' )
endif

SHELL = /usr/bin/env bash -o pipefail
.SHELLFLAGS = -ec

COMPOSE = docker-compose
COMPOSE_FILE = docker-compose.yml

WIRE = go tool -modfile=tools.mod wire
MIGRATE = go tool -modfile=tools.mod migrate

##@ Help

.PHONY: help
help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Wire

.PHONY: wire
wire: ## Generate wire dependency injection code
	$(WIRE) ./cmd/app

##@ Database

.PHONY: migrate-up
migrate-up: ## Run DB migrations
	$(MIGRATE) -path db/migrations -database "postgres://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@localhost:5432/$(POSTGRES_DB)?sslmode=disable" up

.PHONY: migrate-down
migrate-down: ## Roll back last DB migration
	$(MIGRATE) -path db/migrations -database "postgres://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@localhost:5432/$(POSTGRES_DB)?sslmode=disable" down 1

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
