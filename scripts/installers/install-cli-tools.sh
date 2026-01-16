#!/usr/bin/env bash
# Install CLI tools and utilities
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Installing core CLI tools"

# btop - modern resource monitor
dnf_install btop

# fastfetch - modern system info tool (replaces neofetch which is archived)
dnf_install fastfetch

# inxi - system information tool
dnf_install inxi

section "Installing modern CLI replacements"

# bat - better cat with syntax highlighting
dnf_install bat

# eza - modern ls replacement (formerly exa)
# Not in Fedora repos since F42, install via cargo
if ! is_installed eza; then
  if is_installed cargo; then
    info "Installing eza via cargo..."
    cargo install eza
  else
    warn "cargo not installed, skipping eza (install Rust first)"
  fi
else
  info "eza already installed"
fi

# zoxide - smarter cd with frecency tracking
dnf_install zoxide

# dust - better du visualization
dnf_install dust

section "Installing data processing tools"

# jq - JSON processor (essential)
dnf_install jq

# yq - YAML/XML/TOML processor
dnf_install yq

section "Installing documentation tools"

# tldr - simplified man pages with examples
dnf_install tldr

section "Installing shell enhancements"

# gum - glamorous shell scripts (pretty prompts, spinners, etc.)
dnf_install gum

# starship - cross-shell prompt
if ! is_installed starship; then
  info "Installing starship prompt..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y
else
  info "starship already installed"
fi

section "Shell integration setup"

info "CLI tools installed successfully"
echo ""
info "To enable these tools, add to your ~/.bashrc:"
echo ""
echo "  # zoxide (smarter cd)"
echo "  eval \"\$(zoxide init bash)\""
echo ""
echo "  # starship prompt"
echo "  eval \"\$(starship init bash)\""
echo ""
echo "  # Aliases for modern replacements"
echo "  alias cat='bat --paging=never'"
echo "  alias ls='eza'"
echo "  alias ll='eza -la'"
echo "  alias tree='eza --tree'"
echo "  alias du='dust'"
echo ""
