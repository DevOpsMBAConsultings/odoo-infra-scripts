cat > install/20_run_nginx.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

echo "==> Running modules/nginx/run.sh"
chmod +x modules/nginx/run.sh
chmod +x modules/nginx/scripts/*.sh
./modules/nginx/run.sh
EOF

chmod +x install/20_run_nginx.sh