#!/usr/bin/env bash
set -euo pipefail

DC="docker compose --env-file .env -f docker-compose.yml -f docker-compose.local.yml"

$DC exec -T app ./vendor/bin/drush updatedb -y
$DC exec -T app ./vendor/bin/drush entity:updates -y || true
$DC exec -T app ./vendor/bin/drush cache:rebuild
$DC exec -T app ./vendor/bin/drush config:status || true

echo "Post-import tasks completed."
