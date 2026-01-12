#!/usr/bin/env bash
# Install GNU Stow and apply all dotfile configurations
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

DOTFILES_DIR="$HOME/dotfiles"

section "Installing Stow"

# Install stow and git
dnf_install stow
dnf_install git

# List of stow packages to apply
STOW_PACKAGES=(
  bash
  git
  nvim
  kitty
  cosmic
  mise
  lazygit
  lazydocker
  tidewave
  flameshot
  claude
  gearlever
)

section "Applying stow packages"

cd "$DOTFILES_DIR"

for pkg in "${STOW_PACKAGES[@]}"; do
  if [[ -d "$DOTFILES_DIR/$pkg" ]]; then
    info "Stowing $pkg..."
    stow -v -d "$DOTFILES_DIR" -t "$HOME" "$pkg" 2>&1 | grep -v "^$" || true
  else
    warn "Package $pkg not found in $DOTFILES_DIR, skipping"
  fi
done

info "Stow packages applied successfully"
