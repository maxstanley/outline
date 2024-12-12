COMPOSE:=docker compose
up:
	$(COMPOSE) up -d redis postgres
	yarn install-local-ssl
	yarn install --pure-lockfile
	yarn dev:watch

build:
	$(COMPOSE) build --pull outline

test:
	$(COMPOSE) up -d redis postgres
	NODE_ENV=test yarn sequelize db:drop
	NODE_ENV=test yarn sequelize db:create
	NODE_ENV=test yarn sequelize db:migrate
	yarn test

watch:
	$(COMPOSE) up -d redis postgres
	NODE_ENV=test yarn sequelize db:drop
	NODE_ENV=test yarn sequelize db:create
	NODE_ENV=test yarn sequelize db:migrate
	yarn test:watch

destroy:
	$(COMPOSE) stop
	$(COMPOSE) rm -f

.PHONY: up build destroy test watch # let's go to reserve rules names
