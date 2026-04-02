#!/usr/bin/env bash
set -euo pipefail

if [ "${XDEBUG_MODE:-off}" = "off" ]; then
  export XDEBUG_MODE=off
fi

mkdir -p /var/www/private /var/www/html/web/sites/default/files
chown -R www-data:www-data /var/www/private /var/www/html/web/sites/default/files

# WSL bind mounts often appear with host UID/GID; mark workspace as safe for Composer VCS metadata reads.
git config --global --add safe.directory /var/www/html || true

exec "$@"
