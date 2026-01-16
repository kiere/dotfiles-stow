#!/usr/bin/env bash
# Install fonts (Cascadia Code, Nerd Font Symbols, Noto fonts)
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
fi

section "Installing Noto fonts for Unicode coverage"

# Noto fonts provide excellent Unicode coverage for international text
dnf_install google-noto-fonts-common

# Emoji support
dnf_install google-noto-emoji-fonts

# CJK (Chinese, Japanese, Korean) fonts
dnf_install google-noto-sans-cjk-fonts

section "Updating font cache"

info "Rebuilding font cache..."
fc-cache -fv

info "Fonts installed successfully"
echo ""
info "Installed fonts:"
echo "  - Cascadia Code: Modern monospace font from Microsoft"
echo "  - Nerd Font Symbols: Icons for terminal/editor (use as fallback)"
echo "  - Noto Sans/Serif: Unicode text coverage"
echo "  - Noto Emoji: Color emoji support"
echo "  - Noto CJK: Chinese, Japanese, Korean characters"
echo ""
info "Font configuration tips:"
echo "  - Set Cascadia Code as your terminal/editor font"
echo "  - Add 'Symbols Nerd Font' as a fallback for icons"
echo "  - Noto fonts will automatically be used as fallbacks for missing glyphs"
echo ""
