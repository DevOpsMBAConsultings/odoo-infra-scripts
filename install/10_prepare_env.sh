cat > install/10_prepare_env.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

ENV_FILE="nginx/env/.env"
EXAMPLE_ENV="nginx/env/example.env"

if [ ! -f "$ENV_FILE" ]; then
  echo "==> Creating $ENV_FILE from $EXAMPLE_ENV"
  cp "$EXAMPLE_ENV" "$ENV_FILE"
fi

echo "==> Applying MBA standard defaults to $ENV_FILE"
grep -q '^ODOO_UPSTREAM_HOST=' "$ENV_FILE" && sed -i 's/^ODOO_UPSTREAM_HOST=.*/ODOO_UPSTREAM_HOST=127.0.0.1/' "$ENV_FILE" || echo "ODOO_UPSTREAM_HOST=127.0.0.1" >> "$ENV_FILE"
grep -q '^ODOO_UPSTREAM_PORT=' "$ENV_FILE" && sed -i 's/^ODOO_UPSTREAM_PORT=.*/ODOO_UPSTREAM_PORT=8069/' "$ENV_FILE" || echo "ODOO_UPSTREAM_PORT=8069" >> "$ENV_FILE"
grep -q '^NGINX_SITE_NAME=' "$ENV_FILE" && sed -i 's/^NGINX_SITE_NAME=.*/NGINX_SITE_NAME=odoo-ip/' "$ENV_FILE" || echo "NGINX_SITE_NAME=odoo-ip" >> "$ENV_FILE"
grep -q '^USE_UFW=' "$ENV_FILE" && sed -i 's/^USE_UFW=.*/USE_UFW=true/' "$ENV_FILE" || echo "USE_UFW=true" >> "$ENV_FILE"

echo "✅ Env ready: $ENV_FILE"
EOF