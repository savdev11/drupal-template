#!/usr/bin/env bash
set -euo pipefail

FILE_PATH="${1:-}"
if [ -z "$FILE_PATH" ]; then
  echo "Usage: ./scripts/db/import.sh <dump.sql|dump.sql.gz>"
  exit 1
fi

if [ ! -f "$FILE_PATH" ]; then
  echo "File not found: $FILE_PATH"
  exit 1
fi

DC="docker compose --env-file .env -f docker-compose.yml -f docker-compose.local.yml"
DB_NAME="${DB_NAME:-drupal}"
DB_USER="${DB_USER:-drupal}"
DB_PASSWORD="${DB_PASSWORD:-drupal}"

if [[ "$FILE_PATH" == *.gz ]]; then
  gunzip -c "$FILE_PATH" | $DC exec -T db mariadb -u"$DB_USER" -p"$DB_PASSWORD" "$DB_NAME"
else
  cat "$FILE_PATH" | $DC exec -T db mariadb -u"$DB_USER" -p"$DB_PASSWORD" "$DB_NAME"
fi

./scripts/db/post-import.sh
