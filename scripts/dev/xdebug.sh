#!/usr/bin/env bash
set -euo pipefail

MODE="${1:-}"
if [ "$MODE" != "on" ] && [ "$MODE" != "off" ]; then
  echo "Usage: ./scripts/dev/xdebug.sh <on|off>"
  exit 1
fi

if [ ! -f .env ]; then
  echo "Missing .env file."
  exit 1
fi

if [ "$MODE" = "on" ]; then
  sed -i 's/^XDEBUG_MODE=.*/XDEBUG_MODE=debug,develop/' .env
else
  sed -i 's/^XDEBUG_MODE=.*/XDEBUG_MODE=off/' .env
fi

docker compose --env-file .env -f docker-compose.yml -f docker-compose.local.yml up -d --build app

echo "Xdebug mode set to $MODE."
