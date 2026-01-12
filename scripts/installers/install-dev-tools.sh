#!/usr/bin/env bash
# Install development tools and build dependencies
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Installing Development Tools"

# Install Development Tools group
info "Installing Development Tools group..."
dnf_group_install "Development Tools"

section "Installing Ruby build dependencies"

# Ruby build dependencies (for mise to compile Ruby)
RUBY_DEPS=(
  openssl-devel
  readline-devel
  zlib-devel
  libyaml-devel
  libffi-devel
  rust
  cargo
)

for pkg in "${RUBY_DEPS[@]}"; do
  dnf_install "$pkg"
done

section "Installing Elixir/Erlang build dependencies"

# Elixir/Erlang build dependencies
ERLANG_DEPS=(
  ncurses-devel
  wxGTK3-devel
)

for pkg in "${ERLANG_DEPS[@]}"; do
  dnf_install "$pkg"
done

section "Installing Phoenix live reload dependency"

# inotify-tools for Phoenix live reload
dnf_install inotify-tools

info "Development tools installed successfully"
