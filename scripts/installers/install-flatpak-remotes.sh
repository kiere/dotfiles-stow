#!/usr/bin/env bash
# Configure Flatpak remotes
# Note: Fedora already includes Flathub system-wide, so we only add COSMIC
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Configuring Flatpak remotes"

# Verify Flathub exists (Fedora ships with it)
if flatpak remotes --system | grep -q flathub; then
  info "Flathub remote already configured (system-wide)"
else
  info "Adding Flathub remote (system-wide)..."
  flatpak remote-add --system --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
fi

# Add COSMIC remote (system-wide)
if flatpak remotes --system | grep -q cosmic; then
  info "COSMIC remote already configured"
else
  info "Adding COSMIC remote (system-wide)..."
  sudo flatpak remote-add --system --if-not-exists cosmic https://apt.pop-os.org/cosmic/cosmic.flatpakrepo
fi

info "Flatpak remotes configured successfully"
flatpak remotes --system
