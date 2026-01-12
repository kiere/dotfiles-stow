#!/usr/bin/env bash
# Install CLI tools (btop, fastfetch)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Installing btop"

# btop - modern resource monitor
dnf_install btop

section "Installing fastfetch"

# fastfetch - modern system info tool (replaces neofetch which is archived)
dnf_install fastfetch

info "CLI tools installed successfully"
