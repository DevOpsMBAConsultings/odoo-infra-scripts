#!/usr/bin/env bash
set -euo pipefail

# Resolve repo root
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

ENV_FILE="$BASE_DIR/nginx/env/.env"
TEMPLATE="$BASE_DIR/nginx/templates/odoo-ip-only.conf.template"

# Validate env
if [ ! -f "$ENV_FILE" ]; then
  echo "❌ Missing nginx/env/.env"
  exit 1
fi

set -a
source "$ENV_FILE"
set +a

# Validate template
if [ ! -f "$TEMPLATE" ]; then
  echo "❌ Missing template: $TEMPLATE"
  exit 1
fi

# Defaults (safety)
NGINX_SITE_NAME="${NGINX_SITE_NAME:-odoo-ip}"
ODOO_UPSTREAM_HOST="${ODOO_UPSTREAM_HOST:-127.0.0.1}"
ODOO_UPSTREAM_PORT="${ODOO_UPSTREAM_PORT:-8069}"

OUT_FILE="/etc/nginx/sites-available/${NGINX_SITE_NAME}"

echo "==> Creating Nginx site: $OUT_FILE"

# Render template
tmp="$(mktemp)"
sed \
  -e "s|ODOO_UPSTREAM_HOST|${ODOO_UPSTREAM_HOST}|g" \
  -e "s|ODOO_UPSTREAM_PORT|${ODOO_UPSTREAM_PORT}|g" \
  "$TEMPLATE" > "$tmp"

# Install site
sudo cp "$tmp" "$OUT_FILE"
rm -f "$tmp"

# Disable default site if present
if [ -e /etc/nginx/sites-enabled/default ]; then
  sudo rm -f /etc/nginx/sites-enabled/default
fi

# Enable site (idempotent)
sudo ln -sf "$OUT_FILE" "/etc/nginx/sites-enabled/${NGINX_SITE_NAME}"

# Validate & reload
sudo nginx -t
sudo systemctl reload nginx

echo "✅ Nginx site enabled: ${NGINX_SITE_NAME}"