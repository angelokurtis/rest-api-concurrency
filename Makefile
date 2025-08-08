# Load environment variables from .env file if present
ifneq (,$(wildcard .env))
	include .env
	export $(shell grep -v '^#' .env | sed '/^\s*$$/d' | sed 's/=.*//' )
endif

SHELL = /usr/bin/env bash -o pipefail
.SHELLFLAGS = -ec

COMPOSE = docker compose
COMPOSE_FILE = compose.yaml

WIRE = go tool -modfile=tools.mod wire
# Use `go run` for golang-migrate instead of `go tool` due to a known limitation:
# `go tool` does not respect build tags (like `postgres`), which causes a missing driver error.
# See: https://github.com/golang-migrate/migrate/issues/1232
MIGRATE = go run -mod=mod -tags 'postgres' github.com/golang-migrate/migrate/v4/cmd/migrate@v4.18.3
SQLC = go tool -modfile=tools.mod sqlc

##@ Help

.PHONY: help
help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Wire

.PHONY: wire
wire: ## Generate wire dependency injection code
	@$(WIRE) ./cmd/app

##@ Database

.PHONY: sqlc-generate
sqlc-generate: ## Generate Go code from SQL using sqlc
	@find ./internal/db -type f ! -name 'conn.go' ! -name 'repos.go' ! -name 'wire_provs.go' -delete
	@find ./internal/db -type d -empty -delete
	@$(SQLC) generate -f db/sqlc.yaml

.PHONY: migrate-up
migrate-up: ## Run DB migrations
	@$(MIGRATE) -path db/migrations -database "postgres://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@localhost:5432/$(POSTGRES_DB)?sslmode=disable" up

.PHONY: migrate-down
migrate-down: ## Roll back last DB migration
	@$(MIGRATE) -path db/migrations -database "postgres://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@localhost:5432/$(POSTGRES_DB)?sslmode=disable" down 1

##@ Docker Compose

.PHONY: up
up: ## Start Docker Compose in detached mode
	@$(COMPOSE) -f $(COMPOSE_FILE) up -d

.PHONY: down
down: ## Stop and remove containers
	@$(COMPOSE) -f $(COMPOSE_FILE) down

.PHONY: logs
logs: ## Follow container logs
	@$(COMPOSE) -f $(COMPOSE_FILE) logs -f

.PHONY: ps
ps: ## Show status of containers
	@$(COMPOSE) -f $(COMPOSE_FILE) ps

.PHONY: restart
restart: down up ## Restart containers

.PHONY: clean
clean: ## Remove containers and volumes
	@$(COMPOSE) -f $(COMPOSE_FILE) down -v
