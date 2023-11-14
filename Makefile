DATABASE_URL:=postgres://postgres:foobarbaz@db:5432/postgres
export DATABASE_URL

.PHONY: help
help: # View all make targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: start
start: ## Start all containers
		@echo Starting all
		docker compose up -d

.PHONY: stop
stop: ## Stop all containers
		@echo Stopping all
		docker compose down