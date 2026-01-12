#!/usr/bin/env bash
# Configure Flatpak remotes (Flathub, COSMIC)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Configuring Flatpak remotes"

# Add Flathub remote (user-level)
info "Adding Flathub remote..."
flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Add COSMIC remote (user-level)
info "Adding COSMIC remote..."
flatpak remote-add --user --if-not-exists cosmic https://apt.pop-os.org/cosmic/cosmic.flatpakrepo

info "Flatpak remotes configured successfully"
flatpak remotes --user
