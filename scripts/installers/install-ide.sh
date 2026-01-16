#!/usr/bin/env bash
# Install Neovim, LazyVim dependencies, lazygit, lazydocker, and dev CLI tools
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

# tree-sitter-cli for nvim grammar compilation
if ! is_installed tree-sitter; then
  info "Installing tree-sitter-cli via cargo..."
  if is_installed cargo; then
    cargo install tree-sitter-cli
  else
    warn "cargo not installed, skipping tree-sitter-cli (install Rust first)"
  fi
else
  info "tree-sitter-cli already installed"
fi

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

section "Installing GitHub CLI"

# gh - GitHub from the terminal
dnf_install gh

section "Installing 1Password CLI"

# 1Password CLI for secret management in projects
# Uses the same repo as 1Password desktop app
if ! test -f /etc/yum.repos.d/1password.repo; then
  info "Adding 1Password repository..."
  sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
  echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://downloads.1password.com/linux/keys/1password.asc" | sudo tee /etc/yum.repos.d/1password.repo > /dev/null
fi

dnf_install 1password-cli

info "IDE tools installed successfully"
echo ""
info "1Password CLI usage:"
echo "  op signin                    # Sign in to 1Password"
echo "  op item list                 # List all items"
echo "  op read 'op://vault/item/field'  # Read a secret"
echo "  op run -- command            # Run command with secrets injected"
echo ""
info "GitHub CLI usage:"
echo "  gh auth login                # Authenticate with GitHub"
echo "  gh repo clone owner/repo     # Clone a repository"
echo "  gh pr create                 # Create a pull request"
echo "  gh issue list                # List issues"
echo ""
