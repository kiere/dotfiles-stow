#!/usr/bin/env bash
# Install AI coding tools (Claude Code, OpenAI Codex)
# No npm required - uses official installers
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Installing Claude Code"

if ! is_installed claude; then
  info "Installing Claude Code via official installer..."
  curl -fsSL https://claude.ai/install.sh | bash
else
  info "Claude Code already installed"
fi

section "Installing OpenAI Codex"

ensure_brew

if ! is_installed codex; then
  info "Installing OpenAI Codex via Homebrew..."
  brew install --cask codex
else
  info "OpenAI Codex already installed"
fi

info "AI coding tools installed successfully"
