#!/usr/bin/env bash
# Install PostgreSQL client (psql) - no server
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Installing PostgreSQL client"

# Install postgresql package (client only, not the server)
dnf_install postgresql

info "PostgreSQL client installed successfully"
psql --version
