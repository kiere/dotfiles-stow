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

# Install mise if not present
if ! command -v mise &> /dev/null; then
  info "Installing mise..."
  curl https://mise.run | sh
  export PATH="$HOME/.local/bin:$PATH"
fi

# Activate mise for this shell session
eval "$(mise activate bash)"

# Create .mise.toml if no mise config exists (check current dir and parent)
if [ ! -f "$SCRIPT_DIR/.mise.toml" ] && [ ! -f "$SCRIPT_DIR/mise.toml" ] && \
   [ ! -f "$(dirname "$SCRIPT_DIR")/.mise.toml" ] && [ ! -f "$(dirname "$SCRIPT_DIR")/mise.toml" ]; then
  info "Creating .mise.toml with Python..."
  cat > "$SCRIPT_DIR/.mise.toml" << 'EOF'
[tools]
python = "latest"
EOF
fi

# Install Python via mise and trust the directory
info "Setting up Python via mise..."
mise trust "$SCRIPT_DIR" 2>/dev/null || true
mise install --cd "$SCRIPT_DIR"

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
