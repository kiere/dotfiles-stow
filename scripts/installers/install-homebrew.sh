#!/usr/bin/env bash
# Install Homebrew (Linux version)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Installing Homebrew"

if is_installed brew; then
  info "Homebrew is already installed"
  exit 0
fi

# Install dependencies for Homebrew
info "Installing Homebrew dependencies..."
sudo dnf install -y procps-ng curl file git

# Install Homebrew non-interactively
info "Installing Homebrew..."
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add to current session
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

info "Homebrew installed successfully"
info "Note: Homebrew PATH is already configured in .bashrc"
