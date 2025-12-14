cat > install/99_summary.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

PUB_IP="$(curl -s ifconfig.me || true)"

echo ""
echo "✅ MBA STANDARD COMPLETE"
echo "Nginx reverse proxy configured for Odoo (Port 80 -> 8069)"
if [ -n "$PUB_IP" ]; then
  echo "Test: http://$PUB_IP"
else
  echo "Test: http://<SERVER_PUBLIC_IP>"
fi
echo ""

if ! systemctl is-active --quiet nginx; then
  echo "❌ Nginx is NOT running"
  echo "❌ Installation failed"
  exit 1
fi

echo "✅ Nginx is running"
echo "✅ Installation completed successfully"

EOF