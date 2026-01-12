#!/usr/bin/env bash
# Install Elixir and Phoenix via mise
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Installing Elixir via mise"

require_mise

# Install latest Elixir as global default
info "Installing Elixir (latest)..."
mise use --global elixir@latest

section "Installing Phoenix dependencies"

# Install Hex package manager
info "Installing Hex..."
mix local.hex --force

# Install rebar3 (Erlang build tool)
info "Installing rebar3..."
mix local.rebar --force

# Install Phoenix application generator
info "Installing Phoenix generator..."
mix archive.install hex phx_new --force

info "Elixir and Phoenix installed successfully"
elixir --version
