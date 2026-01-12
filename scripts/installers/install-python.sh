#!/usr/bin/env bash
# Install Python 3 (latest) via mise
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Installing Python via mise"

require_mise

# Install latest Python 3 as global default
info "Installing Python 3 (latest)..."
mise use --global python@latest

info "Python installed successfully"
python --version
