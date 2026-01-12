#!/usr/bin/env bash
# Install fonts (Cascadia Code, Nerd Font Symbols)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

FONT_DIR="$HOME/.local/share/fonts"

section "Installing Cascadia Code"

dnf_install cascadia-code-fonts

section "Installing Nerd Font Symbols Only"

mkdir -p "$FONT_DIR"

# Check if already installed
if ls "$FONT_DIR"/SymbolsNerdFont*.ttf &>/dev/null; then
  info "Nerd Font Symbols already installed"
else
  info "Downloading Nerd Font Symbols Only..."
  curl -fsSL -o /tmp/NerdFontsSymbolsOnly.zip \
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/NerdFontsSymbolsOnly.zip"

  info "Extracting fonts..."
  unzip -o /tmp/NerdFontsSymbolsOnly.zip -d "$FONT_DIR"
  rm /tmp/NerdFontsSymbolsOnly.zip

  info "Updating font cache..."
  fc-cache -fv
fi

info "Fonts installed successfully"
