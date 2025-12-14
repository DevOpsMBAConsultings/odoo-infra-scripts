#!/usr/bin/env bash
set -euo pipefail

echo ""
echo "=============================="
echo "✅ MBA STANDARD INSTALL SUMMARY"
echo "=============================="
echo "Component : Nginx Reverse Proxy for Odoo"
echo "Mapping   : Port 80  →  Port 8069"
echo ""

# Detect public IP (best effort)
PUB_IP="$(curl -4 -s ifconfig.me || true)"

if [ -n "$PUB_IP" ]; then
  echo "🌐 Test URL:"
  echo "    http://${PUB_IP}"
else
  echo "🌐 Test URL:"
  echo "    http://<SERVER_PUBLIC_IP>"
fi

echo ""

# Service validation
if systemctl is-active --quiet nginx; then
  echo "✅ Nginx service: RUNNING"
else
  echo "❌ Nginx service: NOT RUNNING"
  echo ""
  echo "Troubleshooting:"
  echo "  sudo systemctl status nginx"
  echo "  sudo nginx -t"
  echo "  sudo tail -n 50 /var/log/nginx/error.log"
  exit 1
fi

echo ""
echo "✅ INSTALLATION COMPLETED SUCCESSFULLY"
echo "=============================="
echo ""