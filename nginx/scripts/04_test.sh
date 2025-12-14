#!/bin/bash
set -e

PUBLIC_IP="$(curl -4 -s ifconfig.me || true)"

echo "🔎 Local test (nginx):"
curl -I --max-time 5 http://127.0.0.1 | head -n 5 || true

echo ""
echo "🔎 Check Odoo upstream listening (8069 expected):"
sudo ss -lntp | grep ":8069" || true

echo ""
echo "🌐 Public test URL:"
echo "http://${PUBLIC_IP}"
echo ""
echo "If it doesn’t load externally, check firewall/security group and nginx error log:"
echo "sudo tail -n 80 /var/log/nginx/error.log"