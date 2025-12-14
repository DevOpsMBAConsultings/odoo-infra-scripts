#!/bin/bash
set -e

apt update
apt install -y nginx
systemctl enable --now nginx

echo "✅ Nginx installed and running"
nginx -v
systemctl --no-pager status nginx | sed -n '1,10p'