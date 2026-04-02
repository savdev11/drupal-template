# Drupal Platform Template

A production-grade GitHub template repository for launching multiple Drupal client websites (shops, associations, foundations, cooperatives, companies, organizations) from a single reusable starter.

## Who this is for

Freelance/solo Drupal engineers who want:

- predictable local/prod parity
- reusable Docker-based infrastructure
- CI/CD guardrails
- clear multi-environment strategy
- portability across self-hosted PaaS tools

## Stack summary

- Drupal (`drupal/recommended-project` layout, Drupal 11 constraint)
- PHP 8.3 FPM
- Nginx
- Varnish
- MariaDB 11.4
- Redis 7
- Mailpit (local)
- Xdebug (toggleable)
- Drush + Composer
- Docker Compose (no DDEV/Lando)

## Why MariaDB as default

MariaDB is a pragmatic default for self-hosted Drupal on VPS:

- easy operational footprint
- excellent compatibility/performance for Drupal workloads
- common availability in self-hosted environments

## Repository usage as template

1. Create a new repository from this template on GitHub.
2. Clone it locally.
3. Copy `.env.example` to `.env` and adapt values.
4. Run `make init`.

## Prerequisites

- WSL2 (Ubuntu)
- Docker Engine + Docker Compose plugin
- Git
- Make

## First-time setup

```bash
cp .env.example .env
make init
```

## Daily commands

```bash
make up
make down
make logs
make drush CMD='status'
make composer CMD='install'
make qa
```

## Environment overview

- `APP_ENV=local|stage|prod`
- `settings.php` loads environment-specific settings includes
- Config Split toggled per environment
- secrets/runtime endpoints loaded from env vars

See:

- `docs/environments.md`
- `docs/config-management.md`

## Deployment overview

- Coolify now: deploy using `docker-compose.yml`
- Dokploy later: reuse same Compose model with platform-level mapping changes

See:

- `docs/deployment-coolify.md`
- `docs/deployment-dokploy.md`

## CI/CD

- CI: `.github/workflows/ci.yml`
- Tag release deploy: `.github/workflows/release-deploy.yml`

Tag example:

- `v0.1.0`

## Included operations scripts

- `make db-import FILE=...`
- `make db-sanitize`
- `make files-pull`
- `make post-import`
- `make xdebug-on`
- `make xdebug-off`

## Notes on Drupal Bootstrap theme

This template includes the Drupal Bootstrap base theme dependency and a minimal custom subtheme scaffold at:

- `web/themes/custom/client_bootstrap`

Validate the exact Bootstrap release compatibility with your final chosen Drupal patch level during project initialization.
