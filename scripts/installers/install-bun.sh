#!/usr/bin/env bash
# Install Bun JavaScript runtime via mise
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Installing Bun via mise"

require_mise

# Install latest Bun as global default
info "Installing Bun (latest)..."
mise use --global bun@latest

info "Bun installed successfully"
bun --version
