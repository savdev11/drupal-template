#!/usr/bin/env bash
set -euo pipefail

if [ "${XDEBUG_MODE:-off}" = "off" ]; then
  export XDEBUG_MODE=off
fi

mkdir -p /var/www/private /var/www/html/web/sites/default/files
chown -R www-data:www-data /var/www/private /var/www/html/web/sites/default/files

exec "$@"
