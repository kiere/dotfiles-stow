#!/usr/bin/env bash
# Install mise version manager
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Installing mise"

# mise is available in Fedora 41+ repos
dnf_install mise

info "mise installed successfully"
info "Note: mise activation is already configured in .bashrc"
