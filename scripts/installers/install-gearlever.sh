#!/usr/bin/env bash
# Install Gear Lever (AppImage manager)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Installing Gear Lever"

# Gear Lever is a Flatpak app for managing AppImages
if flatpak list 2>/dev/null | grep -q "it.mijorus.gearlever"; then
  info "Gear Lever is already installed"
else
  info "Installing Gear Lever via Flatpak..."
  flatpak install -y flathub it.mijorus.gearlever
fi

info "Gear Lever installed successfully"
info "Config will be applied via stow (gearlever package)"
