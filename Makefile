DATABASE_URL:=postgres://postgres:foobarbaz@db:5432/postgres
export DATABASE_URL

.PHONY: build
build:
		echo "FROM scratch" > Dockerfile
		docker build --tag my-scratch-image .
		--rm Dockerfile

.PHONY: start-all
start-all:
		@echo Starting all
		docker compose up -d

.PHONY: stop
stop:
		@echo Stopping all
		docker compose down

.PHONY: run-postgres
run-postgres:
		@echo Starting postgres container
		-docker run \
				-e POSTGRES_PASSWORD=foobarbaz \
				-v pgdata:/var/lib/postgresql/data \
				-p 5432:5432 \
				postgres:15.1-alpine

.PHONY: run-api-golang
run-api-golang:
		@echo Starting golang api
		docker run --rm  \
				--env DATABASE_URL=${DATABASE_URL} \
				api-golang:8

.PHONY: run-client-react
run-client-react:
		@echo Starting react client
		docker run --rm  \
				-p 8080:8080 \
				client-react:5
