#!/usr/bin/env bash
set -euo pipefail

# Load env
ENV_FILE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/env/.env"

if [ ! -f "$ENV_FILE" ]; then
  echo "❌ Missing nginx/env/.env"
  exit 1
fi

set -a
source "$ENV_FILE"
set +a

if [ "${USE_UFW:-true}" != "true" ]; then
  echo "ℹ️ USE_UFW=false, skipping firewall configuration"
  exit 0
fi

echo "==> Configuring UFW firewall rules"

# Ensure UFW is enabled
ufw --force enable

# Open required ports explicitly
ufw allow 80/tcp
ufw allow 443/tcp

# Optional: allow Odoo internally (can be removed later)
ufw allow 8069/tcp || true

ufw reload

echo "✅ UFW configured:"
ufw status