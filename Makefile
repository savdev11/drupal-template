SHELL := /bin/bash

DC := docker compose --env-file .env -f docker-compose.yml -f docker-compose.local.yml
APP := app

.PHONY: help init up down restart logs ps shell composer composer-install drush bootstrap db-import db-sanitize files-pull post-import xdebug-on xdebug-off cs phpmd lint-yaml lint-twig test lint qa clean

.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "%-24s %s\n", $$1, $$2}'

init: ## Copy .env and install dependencies + first bootstrap.
	@if [ ! -f .env ]; then cp .env.example .env; fi
	$(MAKE) up
	$(MAKE) composer-install
	$(MAKE) bootstrap

up: ## Start local stack.
	$(DC) up -d --build

down: ## Stop local stack.
	$(DC) down

restart: ## Restart local stack.
	$(MAKE) down
	$(MAKE) up

logs: ## Tail logs.
	$(DC) logs -f --tail=200

ps: ## Show services status.
	$(DC) ps

shell: ## Open shell in PHP app container.
	$(DC) exec $(APP) bash

composer: ## Run composer command. Usage: make composer CMD='require drush/drush'
	$(DC) exec $(APP) composer $(CMD)

composer-install: ## Install PHP dependencies.
	$(DC) exec $(APP) composer install

drush: ## Run drush command. Usage: make drush CMD='status'
	$(DC) exec $(APP) ./vendor/bin/drush $(CMD)

bootstrap: ## Install Drupal if not installed.
	./scripts/install/bootstrap.sh

db-import: ## Import DB dump. Usage: make db-import FILE=./dump.sql.gz
	./scripts/db/import.sh $(FILE)

db-sanitize: ## Sanitize local DB.
	./scripts/db/sanitize.sh

files-pull: ## Pull remote files via rsync.
	./scripts/files/pull.sh

post-import: ## Run post import tasks.
	./scripts/db/post-import.sh

xdebug-on: ## Enable xdebug in the app container.
	./scripts/dev/xdebug.sh on

xdebug-off: ## Disable xdebug in the app container.
	./scripts/dev/xdebug.sh off

cs: ## Run PHPCS (Drupal standard) on custom code.
	$(DC) exec $(APP) ./vendor/bin/phpcs --standard=phpcs.xml

phpmd: ## Run PHPMD on custom module and theme.
	$(DC) exec $(APP) ./vendor/bin/phpmd web/modules/custom,web/themes/custom text phpmd.xml

lint-yaml: ## Lint YAML files in repo.
	$(DC) exec $(APP) bash -lc "find . -type f \( -name '*.yml' -o -name '*.yaml' \) | xargs -r ./vendor/bin/yaml-lint"

lint-twig: ## Lint Twig templates.
	$(DC) exec $(APP) ./vendor/bin/twigcs web/themes/custom web/modules/custom

test: ## Run PHPUnit tests.
	$(DC) exec $(APP) ./vendor/bin/phpunit -c phpunit.xml.dist

lint: cs phpmd lint-yaml lint-twig ## Run all lint checks.

qa: lint test ## Run lint + tests.

clean: ## Stop and remove containers + anonymous volumes.
	$(DC) down -v --remove-orphans
