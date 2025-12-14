#!/bin/bash
set -e

ENV_FILE="$(dirname "$0")/../../env/.env"
if [ ! -f "$ENV_FILE" ]; then
  echo "❌ Missing env/.env. Copy env/example.env to env/.env first."
  exit 1
fi
source "$ENV_FILE"

if [ "$USE_UFW" = "true" ]; then
  sudo ufw allow 'Nginx Full' || true
  sudo ufw status
  echo "✅ UFW updated (Nginx Full)"
else
  echo "ℹ️ USE_UFW=false, skipping UFW"
fi