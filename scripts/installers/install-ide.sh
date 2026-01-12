#!/usr/bin/env bash
# Install Neovim, LazyVim dependencies, lazygit, and lazydocker
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Installing Neovim"

dnf_install neovim

section "Installing LazyVim dependencies"

# LazyVim requires these tools
dnf_install ripgrep
dnf_install fd-find
dnf_install fzf

section "Installing lazygit"

# Enable COPR repo for lazygit
if ! dnf copr list 2>/dev/null | grep -q "dejan/lazygit"; then
  info "Enabling lazygit COPR repository..."
  sudo dnf copr enable -y dejan/lazygit
fi

dnf_install lazygit

section "Installing lazydocker"

# lazydocker via Homebrew
ensure_brew
if ! is_installed lazydocker; then
  info "Installing lazydocker via Homebrew..."
  brew install lazydocker
else
  info "lazydocker already installed"
fi

info "IDE tools installed successfully"
