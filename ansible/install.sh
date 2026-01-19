#!/bin/bash
# Bootstrap script for Ansible-based dotfiles installation
#
# Usage:
#   ./install.sh              # Full install
#   ./install.sh --tags dev   # Specific tags only
#   ./install.sh --list-tags  # Show available tags
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }

# Detect distro for package manager
detect_distro() {
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "$ID"
  else
    echo "unknown"
  fi
}

DISTRO=$(detect_distro)

# Install stow via package manager (needed for early stow of bash/mise configs)
install_stow() {
  if command -v stow &> /dev/null; then
    return
  fi

  info "Installing stow..."
  case "$DISTRO" in
    fedora)
      sudo dnf install -y stow
      ;;
    ubuntu|pop)
      sudo apt-get update
      sudo apt-get install -y stow
      ;;
    arch|cachyos)
      sudo pacman -S --needed --noconfirm stow
      ;;
    *)
      warn "Unknown distro, attempting to install stow anyway..."
      sudo dnf install -y stow 2>/dev/null || sudo apt-get install -y stow 2>/dev/null || sudo pacman -S --needed --noconfirm stow 2>/dev/null
      ;;
  esac
}

# Stow essential packages early (bash config with mise activation, mise global config)
# This prevents the stow role from breaking ansible mid-playbook
stow_essentials() {
  info "Stowing essential configs (bash, mise)..."

  # Backup existing files if they exist and aren't symlinks
  local timestamp
  timestamp=$(date +%Y%m%dT%H%M%S)

  for file in ~/.bashrc ~/.bash_profile ~/.bash_logout ~/.config/mise/config.toml; do
    if [ -e "$file" ] && [ ! -L "$file" ]; then
      info "Backing up $file to ${file}.bak.${timestamp}"
      mv "$file" "${file}.bak.${timestamp}"
    fi
  done

  # Ensure .config/mise directory exists (prevents stow folding)
  mkdir -p ~/.config/mise

  # Stow bash and mise packages
  stow -v -d "$DOTFILES_DIR" -t "$HOME" bash mise
}

install_stow
stow_essentials

# Source the new bashrc to get mise activation
# shellcheck disable=SC1091
source ~/.bashrc

# Install mise if not present
if ! command -v mise &> /dev/null; then
  info "Installing mise..."
  curl https://mise.run | sh
  export PATH="$HOME/.local/bin:$PATH"
fi

# Activate mise for this shell session
eval "$(mise activate bash)"

# Install tools via mise (Python is defined in ~/.config/mise/config.toml)
info "Setting up tools via mise..."
mise trust 2>/dev/null || true
mise install

# Activate mise again to pick up Python
eval "$(mise activate bash)"
cd "$SCRIPT_DIR"

# Install ansible via pip if not present
if ! command -v ansible-playbook &> /dev/null; then
  info "Installing Ansible via pip..."
  pip install --upgrade pip
  pip install ansible
fi

info "Ansible version: $(ansible --version | head -1)"

# Install required collections
info "Installing Ansible Galaxy collections..."
ansible-galaxy collection install -r "$SCRIPT_DIR/requirements.yml"

# Start sudo keepalive in background (prevents timeout during long playbook runs)
info "Starting sudo keepalive..."
sudo -v
(while true; do sudo -v; sleep 60; done) &
SUDO_KEEPALIVE_PID=$!

# Cleanup function to kill background process
cleanup() {
  if kill -0 "$SUDO_KEEPALIVE_PID" 2>/dev/null; then
    kill "$SUDO_KEEPALIVE_PID" 2>/dev/null
  fi
}
trap cleanup EXIT

# Run playbook (-K passes sudo password to Ansible's become mechanism)
info "Running Ansible playbook..."
ansible-playbook -K -i "$SCRIPT_DIR/inventory/localhost.yml" "$SCRIPT_DIR/playbook.yml" "$@"

info "Installation complete!"
