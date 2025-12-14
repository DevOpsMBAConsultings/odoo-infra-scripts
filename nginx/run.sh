#!/usr/bin/env bash
set -euo pipefail

# Always run from repo root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

ENV_FILE="nginx/env/.env"

if [ ! -f "$ENV_FILE" ]; then
  echo "⚠️  $ENV_FILE not found. Creating default env..."
  cp nginx/env/example.env "$ENV_FILE"
fi

# Load env vars
set -a
source "$ENV_FILE"
set +a

echo "==> Running Nginx shelf (IP-only) for Odoo..."
./nginx/scripts/01_install_nginx.sh
./nginx/scripts/03_open_firewall.sh
./nginx/scripts/02_apply_ip_only_site.sh
./nginx/scripts/04_test.sh

echo "✅ DONE: Nginx reverse proxy configured."