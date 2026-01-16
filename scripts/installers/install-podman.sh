#!/usr/bin/env bash
# Install Podman
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Installing Podman"

dnf_install podman
dnf_install podman-compose

section "Installing Podman Desktop"

if ! flatpak list --system 2>/dev/null | grep -q "io.podman_desktop.PodmanDesktop"; then
  info "Installing Podman Desktop via Flatpak..."
  sudo flatpak install --system -y flathub io.podman_desktop.PodmanDesktop
else
  info "Podman Desktop already installed"
fi

info "Podman installed successfully"
podman --version
