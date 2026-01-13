#!/usr/bin/env bash
# Install Tailscale - mesh VPN for secure networking
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Installing Tailscale"

if ! is_installed tailscale; then
  info "Adding Tailscale repository..."
  sudo dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo

  info "Installing Tailscale..."
  sudo dnf install -y tailscale
else
  info "Tailscale already installed"
fi

section "Enabling Tailscale service"

if ! systemctl is-enabled tailscaled &>/dev/null; then
  info "Enabling and starting tailscaled service..."
  sudo systemctl enable --now tailscaled
else
  info "tailscaled service already enabled"
fi

info "Tailscale installed successfully"
echo ""
info "Getting started:"
echo "  sudo tailscale up              # Authenticate and connect"
echo "  tailscale status               # Show connection status"
echo "  tailscale ip                   # Show your Tailscale IP"
echo "  tailscale ping <hostname>      # Ping another device"
echo ""
info "Features:"
echo "  - Mesh VPN: Connect all your devices securely"
echo "  - Magic DNS: Access devices by name (e.g., laptop.tailnet-name.ts.net)"
echo "  - Exit nodes: Route traffic through another device"
echo "  - SSH: Secure SSH access without port forwarding"
echo "  - Funnel: Expose local services to the internet"
echo ""
info "Web console: https://login.tailscale.com/admin"
echo ""
