#!/usr/bin/env bash
# Install AI coding tools (Claude Code, OpenAI Codex, Copilot CLI, Ollama, LM Studio)
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

section "Installing GitHub Copilot CLI"

# Copilot CLI is a gh extension (requires gh to be installed)
if is_installed gh; then
  if ! gh extension list 2>/dev/null | grep -q "gh-copilot"; then
    info "Installing GitHub Copilot CLI extension..."
    gh extension install github/gh-copilot
  else
    info "GitHub Copilot CLI already installed"
  fi
else
  warn "gh not installed, skipping Copilot CLI (run install-ide.sh first)"
fi

section "Installing Ollama"

# Ollama - run local LLMs
if ! is_installed ollama; then
  info "Installing Ollama..."
  curl -fsSL https://ollama.com/install.sh | sh
else
  info "Ollama already installed"
fi

section "Installing LM Studio"

# LM Studio - GUI for local LLMs (AppImage)
LM_STUDIO_DIR="$HOME/Applications"
LM_STUDIO_APP="$LM_STUDIO_DIR/LM-Studio.AppImage"

if [[ ! -f "$LM_STUDIO_APP" ]]; then
  info "Downloading LM Studio..."
  mkdir -p "$LM_STUDIO_DIR"

  # Get the latest Linux AppImage URL from their releases
  LM_STUDIO_URL="https://releases.lmstudio.ai/linux/x86_64/0.3.10/0/LM-Studio-0.3.10-x64.AppImage"

  curl -fsSL -o "$LM_STUDIO_APP" "$LM_STUDIO_URL"
  chmod +x "$LM_STUDIO_APP"

  info "LM Studio installed to $LM_STUDIO_APP"
  info "Tip: Use Gear Lever to manage AppImages and create desktop entries"
else
  info "LM Studio already installed"
fi

info "AI coding tools installed successfully"
echo ""
info "Usage:"
echo "  claude                # Claude Code CLI"
echo "  codex                 # OpenAI Codex CLI"
echo "  gh copilot suggest    # GitHub Copilot suggestions"
echo "  gh copilot explain    # Explain code/commands"
echo "  ollama run llama3.2   # Run Llama locally"
echo "  ollama list           # List downloaded models"
echo ""
