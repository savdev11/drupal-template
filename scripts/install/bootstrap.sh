#!/usr/bin/env bash
set -euo pipefail

if [ ! -f .env ]; then
  echo "Missing .env file. Copy .env.example first."
  exit 1
fi

DC="docker compose --env-file .env -f docker-compose.yml -f docker-compose.local.yml"

$DC up -d

if [ ! -f vendor/autoload.php ]; then
  $DC exec app composer install
fi

echo "Waiting for database..."
until $DC exec -T db mariadb-admin ping -h"${DB_HOST:-db}" --silent --password="${DB_ROOT_PASSWORD:-drupal_root}"; do
  sleep 2
done

BOOTSTRAP_STATE="$($DC exec -T app ./vendor/bin/drush status --field=bootstrap 2>/dev/null || true)"
if [ "$BOOTSTRAP_STATE" = "Successful" ]; then
  echo "Drupal is already installed."
  exit 0
fi

$DC exec -T app ./vendor/bin/drush site:install standard \
  --account-name="${DRUPAL_ADMIN_USER:-admin}" \
  --account-pass="${DRUPAL_ADMIN_PASS:-admin}" \
  --site-name="${DRUPAL_SITE_NAME:-Drupal Template}" \
  -y

$DC exec -T app ./vendor/bin/drush en -y bootstrap config_split redis smtp stage_file_proxy site_starter
$DC exec -T app ./vendor/bin/drush theme:enable client_bootstrap -y
$DC exec -T app ./vendor/bin/drush config:set system.theme default client_bootstrap -y
$DC exec -T app ./vendor/bin/drush cache:rebuild

echo "Drupal bootstrap completed."
