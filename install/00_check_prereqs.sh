cat > install/00_check_prereqs.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

command -v sudo >/dev/null 2>&1 || { echo "❌ sudo not found"; exit 1; }
command -v systemctl >/dev/null 2>&1 || { echo "❌ systemctl not found"; exit 1; }

echo "✅ Prereqs OK"
EOF