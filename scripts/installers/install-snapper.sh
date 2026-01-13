#!/usr/bin/env bash
# Install and configure Snapper for Btrfs snapshots
# Includes DNF plugin for automatic pre/post transaction snapshots
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Installing Snapper"

dnf_install snapper
dnf_install python3-dnf-plugin-snapper

section "Configuring Snapper for root filesystem"

# Create snapper config for root if it doesn't exist
if ! sudo snapper -c root list &>/dev/null; then
  info "Creating snapper config for root..."
  sudo snapper -c root create-config /
else
  info "Snapper config for root already exists"
fi

section "Configuring Snapper for home filesystem"

# Create snapper config for home if it doesn't exist
if ! sudo snapper -c home list &>/dev/null; then
  info "Creating snapper config for home..."
  sudo snapper -c home create-config /home
else
  info "Snapper config for home already exists"
fi

section "Enabling automatic cleanup"

# Enable timeline snapshots and cleanup for root
sudo snapper -c root set-config "TIMELINE_CREATE=yes"
sudo snapper -c root set-config "TIMELINE_CLEANUP=yes"
sudo snapper -c root set-config "TIMELINE_LIMIT_HOURLY=5"
sudo snapper -c root set-config "TIMELINE_LIMIT_DAILY=7"
sudo snapper -c root set-config "TIMELINE_LIMIT_WEEKLY=4"
sudo snapper -c root set-config "TIMELINE_LIMIT_MONTHLY=6"
sudo snapper -c root set-config "TIMELINE_LIMIT_YEARLY=0"

# Enable timeline snapshots and cleanup for home
sudo snapper -c home set-config "TIMELINE_CREATE=yes"
sudo snapper -c home set-config "TIMELINE_CLEANUP=yes"
sudo snapper -c home set-config "TIMELINE_LIMIT_HOURLY=5"
sudo snapper -c home set-config "TIMELINE_LIMIT_DAILY=7"
sudo snapper -c home set-config "TIMELINE_LIMIT_WEEKLY=4"
sudo snapper -c home set-config "TIMELINE_LIMIT_MONTHLY=6"
sudo snapper -c home set-config "TIMELINE_LIMIT_YEARLY=0"

section "Enabling Snapper timers"

# Enable the timeline and cleanup timers
sudo systemctl enable --now snapper-timeline.timer
sudo systemctl enable --now snapper-cleanup.timer

info "Snapper installed and configured successfully"
echo ""
info "Snapshot retention policy:"
info "  - Hourly:  5 snapshots"
info "  - Daily:   7 snapshots"
info "  - Weekly:  4 snapshots"
info "  - Monthly: 6 snapshots"
echo ""
info "DNF will now automatically create snapshots before/after transactions"
echo ""
info "Useful commands:"
info "  snapper -c root list        # List root snapshots"
info "  snapper -c home list        # List home snapshots"
info "  snapper -c root undochange 1..2  # Rollback changes"
