#!/usr/bin/env bash
# Install Dropbox cloud storage client
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Installing Dropbox dependencies"

# python3-gpg: needed to verify RPM package signature
# libappindicator-gtk3: needed for system tray integration
# https://help.dropbox.com/installs/dropbox-desktop-app-for-linux#Required-software-libraries
dnf_install python3-gpg
dnf_install libappindicator-gtk3

section "Installing Dropbox"

if is_installed dropbox; then
  info "Dropbox is already installed"
  exit 0
fi

# Dropbox provides an official Fedora RPM
# https://www.dropbox.com/install-linux
DROPBOX_RPM_URL="https://linux.dropbox.com/fedora/43/x86_64/nautilus-dropbox-2025.05.20-1.fc42.x86_64.rpm"

info "Downloading and installing Dropbox..."
sudo dnf install -y "$DROPBOX_RPM_URL"

info "Dropbox installed successfully"
info "Run 'dropbox start -i' to complete setup and sign in"
