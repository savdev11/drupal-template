#!/usr/bin/env bash
set -euo pipefail

if [ ! -f .env ]; then
  echo "Missing .env file."
  exit 1
fi

source .env

if [ -z "${REMOTE_SSH_HOST:-}" ] || [ -z "${REMOTE_SSH_USER:-}" ] || [ -z "${REMOTE_FILES_PATH:-}" ]; then
  echo "Set REMOTE_SSH_HOST, REMOTE_SSH_USER and REMOTE_FILES_PATH in .env"
  exit 1
fi

mkdir -p web/sites/default/files
rsync -az --delete "${REMOTE_SSH_USER}@${REMOTE_SSH_HOST}:${REMOTE_FILES_PATH}/" web/sites/default/files/

echo "Files synchronized."
