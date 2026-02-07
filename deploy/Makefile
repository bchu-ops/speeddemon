# --- Path Logic (Industry Standard for Folder Isolation) ---
# MKFILE_PATH: Absolute path to this Makefile (e.g., /user/project/deploy/Makefile)
# MKFILE_DIR:  The directory of this Makefile (/user/project/deploy/)
# ROOT_DIR:    The project root (/user/project/)
# K8S_NAME:  The name of the Kubernetes Secret to sync with .env keys
MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR  := $(dir $(MKFILE_PATH))
ROOT_DIR    := $(abspath $(MKFILE_DIR)..)
K8S_NAME = app-secrets

# --- Docker Variable ---
COMPOSE = docker compose -f $(MKFILE_DIR)docker-compose.yml

.PHONY: help build up down restart logs clean dev dev-up dev-down dev-logs backend-build backend-up backend-down status health sync add test lint shell

# --- Help ---
help: ## Show all available commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# --- Production Commands ---
build: ## Build all Docker images
	$(COMPOSE) build

up: ## Start all services (detached)
	$(COMPOSE) up -d

down: ## Stop all services
	$(COMPOSE) down

restart: ## Restart all services
	$(COMPOSE) restart

logs: ## View logs from all services
	$(COMPOSE) logs -f

clean: ## Deep clean: remove containers, images, volumes, and orphans
	$(COMPOSE) down --rmi all --volumes --remove-orphans

# --- Development Commands ---
dev: ## Start in watch mode (Hot-reload)
	$(COMPOSE) up --watch

dev-up: ## Start development services (detached)
	$(COMPOSE) up -d

dev-down: ## Stop development services
	$(COMPOSE) down

dev-logs: ## View development logs
	$(COMPOSE) logs -f backend

# --- Backend Specific Commands ---
backend-build: ## Build only backend services
	$(COMPOSE) build backend

backend-up: ## Start only backend services
	$(COMPOSE) up -d backend

backend-down: ## Stop only backend services
	$(COMPOSE) stop backend

# --- Status & Health ---
status: ## Show status of all services
	$(COMPOSE) ps

health: ## Check health of all services
	$(COMPOSE) ps --filter "status=running"

# --- Quality & Debugging ---
test: ## Run tests inside the backend container
	$(COMPOSE) run --rm backend pytest

test-cov: ## Run tests and generate a coverage report (HTML)
	$(COMPOSE) run --rm backend pytest --cov=src --cov-report=html

lint: ## Check for code style issues locally
	@cd $(ROOT_DIR) && uv run ruff check .

shell: ## Open a shell in the running backend container
	$(COMPOSE) exec backend bash

# --- Dependency Management (Logic fixed for Folder Isolation) ---
sync: ## Auto-detect missing imports, update pyproject.toml and lockfile
	@echo "🔍 Scanning code for missing packages..."
	@cd $(ROOT_DIR) && uv run deptry . --json | jq -r '.issues.missing | .[]' | xargs -r uv add
	@echo "✅ Dependencies synced locally."

add: ## Add a package manually: make add PKG=pandas
	@if [ -z "$(PKG)" ]; then echo "Usage: make add PKG=package-name"; exit 1; fi
	@cd $(ROOT_DIR) && uv add $(PKG)

# --- Kubernetes Commands ---
k8s-sync-secrets: ## Sync local .env keys to Kubernetes
	@echo "🔐 Syncing .env to Kubernetes Secrets [$(K8S_NAME)]..."
	@kubectl create secret generic $(K8S_NAME) \
		--from-env-file=$(ROOT_DIR)/.env \
		--dry-run=client -o yaml | kubectl apply -f -

k8s-deploy: k8s-sync-secrets ## Deploy everything to Kubernetes (Secrets + App + Service)
	@kubectl apply -f $(MKFILE_DIR)k8s-deployment.yml
	@kubectl apply -f $(MKFILE_DIR)k8s-service.yml
	@echo "🚀 Successfully deployed to Kubernetes!"

# #########		FUTURE?		###########		--- Database Migrations ---

# # If you use a database (PostgreSQL/MySQL), you need commands to update the schema.
# migrate: ## Run database migrations (Alembic/Django)
# 	$(COMPOSE) run --rm backend alembic upgrade head

# migration-new: ## Create a new migration file: make migration-new MSG="add_user_table"
# 	$(COMPOSE) run --rm backend alembic revision --autogenerate -m "$(MSG)"
