# Migrate to Dokploy (Later)

This template intentionally keeps deployment platform logic minimal.

## What can stay unchanged

- `docker-compose.yml`
- Dockerfiles
- `.env` conventions
- Drupal settings strategy
- scripts and Makefile

## Likely adjustments

- Map Dokploy-managed volumes to existing paths.
- Configure Dokploy reverse-proxy/routing labels.
- Recreate environment variables and secrets in Dokploy UI.
- Optionally switch deployment webhooks from Coolify to Dokploy.

## Migration path

1. Import repository into Dokploy.
2. Recreate env vars/secrets.
3. Attach persistent volumes.
4. Point domain + TLS.
5. Trigger deployment from latest tag.
