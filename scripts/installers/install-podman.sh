#!/usr/bin/env bash
# Install Podman
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Installing Podman"

dnf_install podman
dnf_install podman-compose

info "Podman installed successfully"
podman --version
