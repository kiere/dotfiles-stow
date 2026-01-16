#!/usr/bin/env bash
# Install UFW - Uncomplicated Firewall
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Installing UFW"

dnf_install ufw

section "Configuring UFW defaults"

# Set default policies (deny incoming, allow outgoing)
info "Setting default policies..."
sudo ufw default deny incoming
sudo ufw default allow outgoing

section "Allowing common services"

# SSH (always allow to prevent lockout)
info "Allowing SSH (port 22)..."
sudo ufw allow ssh

# LocalSend uses port 53317 for device discovery and file transfer
info "Allowing LocalSend (port 53317)..."
sudo ufw allow 53317/tcp
sudo ufw allow 53317/udp

# KDE Connect / GSConnect (if you use it)
# sudo ufw allow 1714:1764/tcp
# sudo ufw allow 1714:1764/udp

section "Enabling UFW"

if ! sudo ufw status | grep -q "Status: active"; then
  info "Enabling UFW..."
  # --force skips the interactive prompt
  sudo ufw --force enable
else
  info "UFW already enabled"
fi

# Show current status
info "Current firewall status:"
sudo ufw status verbose

info "UFW installed and configured successfully"
echo ""
echo "============================================"
echo "  UFW Quick Reference"
echo "============================================"
echo ""
info "Status commands:"
echo "  sudo ufw status              # Show active rules"
echo "  sudo ufw status verbose      # Show detailed status"
echo "  sudo ufw status numbered     # Show rules with numbers"
echo ""
info "Allow/Deny rules:"
echo "  sudo ufw allow 80            # Allow port 80 (HTTP)"
echo "  sudo ufw allow 443           # Allow port 443 (HTTPS)"
echo "  sudo ufw allow 3000          # Allow dev server port"
echo "  sudo ufw allow ssh           # Allow SSH by service name"
echo "  sudo ufw deny 23             # Deny port 23 (Telnet)"
echo ""
info "Application profiles:"
echo "  sudo ufw app list            # List available app profiles"
echo "  sudo ufw allow 'Apache'      # Allow by app profile"
echo ""
info "Advanced rules:"
echo "  sudo ufw allow from 192.168.1.0/24   # Allow from subnet"
echo "  sudo ufw allow from 192.168.1.100    # Allow from specific IP"
echo "  sudo ufw allow proto tcp to any port 80  # Specific protocol"
echo ""
info "Delete rules:"
echo "  sudo ufw status numbered     # First, get rule numbers"
echo "  sudo ufw delete 3            # Delete rule #3"
echo "  sudo ufw delete allow 80     # Delete by rule specification"
echo ""
info "Enable/Disable:"
echo "  sudo ufw enable              # Enable firewall"
echo "  sudo ufw disable             # Disable firewall"
echo "  sudo ufw reset               # Reset to defaults"
echo ""
info "Logging:"
echo "  sudo ufw logging on          # Enable logging"
echo "  sudo ufw logging medium      # Set log level (low/medium/high)"
echo "  sudo journalctl -f | grep UFW  # View logs"
echo ""
info "Common development ports:"
echo "  3000  - Rails, React dev servers"
echo "  4000  - Phoenix dev server"
echo "  5000  - Flask, many others"
echo "  5173  - Vite dev server"
echo "  8000  - Django, many others"
echo "  8080  - Alternative HTTP"
echo "  5432  - PostgreSQL"
echo "  3306  - MySQL"
echo "  6379  - Redis"
echo ""
