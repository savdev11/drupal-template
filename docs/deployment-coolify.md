# Deploy on Coolify (Now)

## Recommended model

Use **Docker Compose deployment** from this repository.

- Compose file: `docker-compose.yml`
- Optional overrides: environment variables only.

## Required variables in Coolify

At minimum configure:

- `APP_ENV=prod`
- `APP_NAME`
- `APP_BASE_URL`
- `TRUSTED_HOST_PATTERNS`
- `DRUPAL_HASH_SALT`
- `DB_*`
- `REDIS_*`
- `REVERSE_PROXY=true`

## Persistent volumes

Keep persistent:

- `/var/lib/mysql` (`db-data`)
- `/var/www/private` (`private-files`)
- `/var/www/html/web/sites/default/files` (`public-files`)

## Routing

Expose only the front service (Varnish or Nginx) publicly.

Recommended:

- Public: `varnish:80`
- Internal only: app, db, redis

## Deployment trigger

Either:

- Let Coolify auto-deploy on Git push/tag.
- Or use the webhook triggered by `.github/workflows/release-deploy.yml`.
