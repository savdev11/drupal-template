# Environments

This template supports three runtime environments:

- `local`
- `stage`
- `prod`

Set with `APP_ENV` in `.env`.

## Environment files

- `.env.example` for local baseline.
- `.env.stage.example`
- `.env.prod.example`

Copy the matching file in each deployment target and complete secrets.

## Environment behavior

- `local`: `settings.local.php` enabled, local split active, Mailpit + non-aggregated assets.
- `stage`: stage split active, Stage File Proxy allowed.
- `prod`: prod split active, error display restricted.

## Secrets policy

Never commit:

- `.env`
- credentials
- salts
- webhook URLs
