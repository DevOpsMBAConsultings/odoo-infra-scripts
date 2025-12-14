#!/usr/bin/env bash
set -euo pipefail

# Always run from repo root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

ENV_FILE="nginx/env/.env"

if [ ! -f "$ENV_FILE" ]; then
  echo "❌ Missing $ENV_FILE"
  echo "   Create it with: cp nginx/env/example.env nginx/env/.env"
  echo "   Then edit it:   nano nginx/env/.env"
  exit 1
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