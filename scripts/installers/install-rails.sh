#!/usr/bin/env bash
# Install Rails gem
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Installing Rails"

require_mise

# Verify Ruby is available
if ! is_installed ruby; then
  error "Ruby is not installed. Run install-ruby.sh first."
fi

# Install Rails gem
info "Installing Rails..."
gem install rails

info "Rails installed successfully"
rails --version
