#!/usr/bin/env bash
# Install mise version manager
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Installing mise"

# Enable COPR repo for mise
if ! dnf copr list 2>/dev/null | grep -q "jdxcode/mise"; then
  info "Enabling mise COPR repository..."
  sudo dnf copr enable -y jdxcode/mise
fi

dnf_install mise

info "mise installed successfully"
info "Note: mise activation is already configured in .bashrc"
