# Nginx for Odoo (IP-only)

This module sets up Nginx as a reverse proxy to Odoo using the server public IP (no DNS required).

## Run order (on the server)
1) scripts/01_install_nginx.sh
2) scripts/03_open_firewall.sh
3) scripts/02_apply_ip_only_site.sh
4) scripts/04_test.sh

## Notes
- Uses server_name _; (catch-all)
- Designed for testing before DNS + SSL