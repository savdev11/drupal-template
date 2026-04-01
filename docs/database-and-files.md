# Database and Files Workflow

## Import database dump

```bash
make db-import FILE=./dump.sql.gz
```

## Sanitize local copy

```bash
make db-sanitize
```

This runs Drush sanitize and masks user credentials/emails.

## Pull files from remote

Set in `.env`:

- `REMOTE_SSH_HOST`
- `REMOTE_SSH_USER`
- `REMOTE_FILES_PATH`

Then:

```bash
make files-pull
```

## Post import tasks

```bash
make post-import
```

Includes:

- `drush updatedb`
- `drush entity:updates`
- `drush cr`
- `drush config:status`

## Stage File Proxy

For faster local onboarding, set:

```env
STAGE_FILE_PROXY_ORIGIN=https://prod.example.com
```

Then enable module and clear cache.
