#!/usr/bin/env bash
set -euo pipefail

echo "=============================="
echo "🔎 MBA – Nginx / Odoo Validation"
echo "=============================="

# Detect public IP (best effort)
PUBLIC_IP="$(curl -4 -s ifconfig.me || true)"

echo ""
echo "▶ 1) Nginx service status"
systemctl is-active --quiet nginx && echo "✅ Nginx is running" || echo "❌ Nginx is NOT running"

echo ""
echo "▶ 2) Local Nginx HTTP test (127.0.0.1:80)"
if curl -I --max-time 5 http://127.0.0.1 | head -n 5; then
  echo "✅ Nginx responds locally on port 80"
else
  echo "❌ Nginx did NOT respond locally on port 80"
fi

echo ""
echo "▶ 3) Odoo upstream check (127.0.0.1:8069)"
if ss -lntp | grep -q ":8069"; then
  echo "✅ Odoo is listening on port 8069"
else
  echo "❌ Odoo is NOT listening on port 8069"
fi

echo ""
echo "▶ 4) Public access test"
if [ -n "$PUBLIC_IP" ]; then
  echo "🌐 Test in browser: http://${PUBLIC_IP}"
else
  echo "🌐 Test in browser: http://<SERVER_PUBLIC_IP>"
fi

echo ""
echo "▶ 5) Troubleshooting hints"
echo "• Nginx logs:   sudo tail -n 50 /var/log/nginx/error.log"
echo "• Nginx config: sudo nginx -t"
echo "• Firewall:     sudo ufw status"
echo "• Cloud SG:     Verify port 80 allowed"

echo ""
echo "=============================="
echo "✅ Validation script completed"
echo "=============================="