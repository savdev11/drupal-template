# Troubleshooting

## Containers do not start

- Check `make logs`.
- Ensure `.env` exists and has no malformed values.
- Verify ports are free (`8080`, `8081`, `8025`, `33060`, `63790`).

## Drupal cannot connect to DB

- Confirm `DB_HOST=db` for container-to-container networking.
- Confirm credentials in `.env`.
- Rebuild stack: `make down && make up`.

## Config import fails

- Run `make drush CMD='config:status'`.
- Ensure proper split is enabled for current `APP_ENV`.
- Re-export from correct environment if drift was introduced.

## Mail not captured in Mailpit

- Ensure `smtp` module is enabled.
- Verify local `.env` has `SMTP_HOST=mailpit` and `SMTP_PORT=1025`.

## Xdebug not connecting

- Verify `XDEBUG_CLIENT_HOST=host.docker.internal`.
- Use `make xdebug-on` then restart IDE listener.
