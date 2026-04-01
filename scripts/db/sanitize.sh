#!/usr/bin/env bash
set -euo pipefail

DC="docker compose --env-file .env -f docker-compose.yml -f docker-compose.local.yml"

$DC exec -T app ./vendor/bin/drush sql:sanitize -y
$DC exec -T app ./vendor/bin/drush sql:query "UPDATE users_field_data SET mail = CONCAT(name, '+local@example.test');"
$DC exec -T app ./vendor/bin/drush sql:query "UPDATE users_field_data SET pass = '' WHERE uid > 1;"
$DC exec -T app ./vendor/bin/drush cache:rebuild

echo "Local database sanitized."
