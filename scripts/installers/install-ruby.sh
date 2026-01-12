#!/usr/bin/env bash
# Install Ruby 4.0 and 3.4.x via mise
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Installing Ruby via mise"

require_mise

# Install Ruby 4.0 as global default
info "Installing Ruby 4.0..."
mise use --global ruby@4.0

# Also install Ruby 3.4.x (available but not default)
info "Installing Ruby 3.4.x..."
mise install ruby@3.4

section "Installing global gems"

# Install bundler
info "Installing bundler..."
gem install bundler

info "Ruby installed successfully"
info "Ruby 4.0 is set as the global default"
info "Ruby 3.4.x is also available (use: mise use ruby@3.4)"
