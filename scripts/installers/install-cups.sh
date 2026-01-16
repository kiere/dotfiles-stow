#!/usr/bin/env bash
# Install CUPS printing system
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Installing CUPS printing system"

# Core CUPS packages
dnf_install cups
dnf_install cups-filters

# Printer browsing (discover network printers)
dnf_install cups-browsed

# GUI for printer configuration
dnf_install system-config-printer

# Avahi for network printer discovery (mDNS/Bonjour)
dnf_install avahi
dnf_install nss-mdns

section "Enabling print services"

# Enable and start CUPS
if ! systemctl is-enabled cups &>/dev/null; then
  info "Enabling CUPS service..."
  sudo systemctl enable --now cups
else
  info "CUPS service already enabled"
fi

# Enable Avahi for network printer discovery
if ! systemctl is-enabled avahi-daemon &>/dev/null; then
  info "Enabling Avahi daemon..."
  sudo systemctl enable --now avahi-daemon
else
  info "Avahi daemon already enabled"
fi

# Enable cups-browsed for automatic printer discovery
if ! systemctl is-enabled cups-browsed &>/dev/null; then
  info "Enabling cups-browsed service..."
  sudo systemctl enable --now cups-browsed
else
  info "cups-browsed service already enabled"
fi

section "Configuring mDNS for network printers"

# Ensure mDNS is configured in nsswitch.conf for printer discovery
if ! grep -q "mdns" /etc/nsswitch.conf; then
  info "Adding mDNS to nsswitch.conf..."
  sudo sed -i 's/hosts:.*/hosts:      files mdns_minimal [NOTFOUND=return] dns myhostname/' /etc/nsswitch.conf
else
  info "mDNS already configured in nsswitch.conf"
fi

info "CUPS printing system installed successfully"
echo ""
info "Printer management:"
echo "  system-config-printer        # GUI printer configuration"
echo "  http://localhost:631         # CUPS web interface"
echo ""
info "Command line tools:"
echo "  lpstat -p                    # List printers"
echo "  lpstat -d                    # Show default printer"
echo "  lp file.pdf                  # Print a file"
echo "  lp -d PrinterName file.pdf   # Print to specific printer"
echo "  lpq                          # Show print queue"
echo "  cancel -a                    # Cancel all print jobs"
echo ""
info "Adding a printer:"
echo "  1. Open 'system-config-printer' or go to http://localhost:631"
echo "  2. Click 'Add' or 'Add Printer'"
echo "  3. Network printers should be auto-discovered"
echo "  4. For USB printers, connect and they should appear automatically"
echo ""
