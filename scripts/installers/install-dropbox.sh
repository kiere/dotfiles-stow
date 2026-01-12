#!/usr/bin/env bash
# Install Dropbox cloud storage client
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Installing Dropbox"

if is_installed dropbox; then
  info "Dropbox is already installed"
  exit 0
fi

# Dropbox provides an official Fedora RPM
# https://www.dropbox.com/install-linux
DROPBOX_RPM_URL="https://linux.dropbox.com/packages/fedora/nautilus-dropbox-2024.04.17-1.fedora.x86_64.rpm"

info "Downloading and installing Dropbox..."
sudo dnf install -y "$DROPBOX_RPM_URL"

info "Dropbox installed successfully"
info "Run 'dropbox start -i' to complete setup and sign in"
