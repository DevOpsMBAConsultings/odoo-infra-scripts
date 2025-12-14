#!/bin/bash
set -e

sudo apt update
sudo apt install -y nginx
sudo systemctl enable --now nginx

echo "✅ Nginx installed and running"
sudo nginx -v
sudo systemctl --no-pager status nginx | sed -n '1,10p'