#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_ROOT"

echo "🚀 MBA – Odoo Infrastructure Installer (Nginx Reverse Proxy)"
echo "==========================================================="

for f in install/*.sh; do
  echo ""
  echo "==> Running $f"
  bash "$f"
done

echo ""
echo "✅ Installation completed successfully"