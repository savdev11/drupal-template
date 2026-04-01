# Environments

This template supports four runtime environments:

- `local`
- `dev`
- `stage`
- `prod`

Set with `APP_ENV` in `.env`.

## Environment files

- `.env.example` for local baseline.
- `.env.dev.example`
- `.env.stage.example`
- `.env.prod.example`

Copy the matching file in each deployment target and complete secrets.

## Environment behavior

- `local`: `settings.local.php` enabled, local split active, Mailpit + non-aggregated assets.
- `dev`: dev split active, Stage File Proxy allowed.
- `stage`: stage split active, Stage File Proxy allowed.
- `prod`: prod split active, error display restricted.

## Secrets policy

Never commit:

- `.env`
- credentials
- salts
- webhook URLs
