cat > install/20_run_nginx.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

chmod +x nginx/run.sh
chmod +x nginx/scripts/*.sh

echo "==> Running nginx/run.sh"
./nginx/run.sh
EOF