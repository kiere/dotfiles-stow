#!/bin/bash
# Bootstrap script for Ansible-based dotfiles installation
#
# Usage:
#   ./install.sh              # Full install
#   ./install.sh --tags dev   # Specific tags only
#   ./install.sh --list-tags  # Show available tags
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }

# Check for ansible
if ! command -v ansible-playbook &> /dev/null; then
  echo "Ansible not found. Installing..."

  # Detect distro and install ansible
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    case "$ID" in
      fedora)
        sudo dnf install -y ansible
        ;;
      ubuntu|pop)
        sudo apt-get update
        sudo apt-get install -y ansible
        ;;
      arch|cachyos)
        sudo pacman -S --needed --noconfirm ansible
        ;;
      *)
        echo "Unsupported distribution: $ID"
        echo "Please install Ansible manually and re-run this script."
        exit 1
        ;;
    esac
  else
    echo "Cannot detect distribution. Please install Ansible manually."
    exit 1
  fi
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

# Run playbook
info "Running Ansible playbook..."
ansible-playbook -i "$SCRIPT_DIR/inventory/localhost.yml" "$SCRIPT_DIR/playbook.yml" "$@"

info "Installation complete!"
