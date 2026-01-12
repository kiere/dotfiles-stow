#!/usr/bin/env bash
# Helper functions for install scripts

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

info() {
  echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
  echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
  echo -e "${RED}[ERROR]${NC} $1"
  exit 1
}

section() {
  echo -e "\n${BLUE}==>${NC} $1"
}

is_installed() {
  command -v "$1" &>/dev/null
}

dnf_install() {
  local pkg="$1"
  if ! rpm -q "$pkg" &>/dev/null; then
    info "Installing $pkg..."
    sudo dnf install -y "$pkg"
  else
    info "$pkg already installed"
  fi
}

dnf_group_install() {
  local group="$1"
  if ! dnf group list installed 2>/dev/null | grep -q "$group"; then
    info "Installing group $group..."
    sudo dnf group install -y "$group"
  else
    info "Group $group already installed"
  fi
}

ensure_brew() {
  if ! is_installed brew; then
    error "Homebrew is not installed. Run install-homebrew.sh first."
  fi
  # Ensure brew is in PATH for current session
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
}

require_mise() {
  if ! is_installed mise; then
    error "mise is not installed. Run install-mise.sh first."
  fi
  # Activate mise for current session
  eval "$(mise activate bash)"
}
