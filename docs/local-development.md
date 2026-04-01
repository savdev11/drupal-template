# Local Development (WSL2 + Docker Compose)

## Prerequisites

- WSL2 Ubuntu environment.
- Docker Engine + Docker Compose plugin.
- GNU Make.

## First Run

```bash
cp .env.example .env
make init
```

Access:

- Site via Varnish: `http://localhost:8080`
- Direct Nginx (bypass cache): `http://localhost:8081`
- Mailpit UI: `http://localhost:8025`

## Daily Commands

```bash
make up
make down
make logs
make drush CMD='status'
make composer CMD='install'
make shell
```

## Xdebug

```bash
make xdebug-on
make xdebug-off
```

Set IDE server mapping:

- Server name: `drupal-template` (or your custom one)
- Project path in container: `/var/www/html`
