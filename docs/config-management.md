# Config Management

## Strategy

- Canonical config lives in `config/sync`.
- Environment-only config deltas use Config Split:
  - `config/splits/local`
  - `config/splits/dev`
  - `config/splits/stage`
  - `config/splits/prod`

Split activation is controlled in `settings.php` includes by `APP_ENV`.

## Workflow

Export config after changes:

```bash
make drush CMD='config:export -y'
```

Import config:

```bash
make drush CMD='config:import -y'
```

Check drift:

```bash
make drush CMD='config:status'
```

## What belongs where

- `config/sync`: structural site configuration.
- `.env` / `settings.php`: secrets, hostnames, credentials, runtime endpoints.
