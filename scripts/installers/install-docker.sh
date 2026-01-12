#!/usr/bin/env bash
# Install Docker CE
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Installing Docker CE"

# Check if Docker is already installed
if is_installed docker; then
  info "Docker is already installed"
  docker --version
  exit 0
fi

# Remove old versions if present
info "Removing old Docker versions (if any)..."
sudo dnf remove -y docker \
  docker-client \
  docker-client-latest \
  docker-common \
  docker-latest \
  docker-latest-logrotate \
  docker-logrotate \
  docker-engine 2>/dev/null || true

# Set up the Docker repository
info "Adding Docker repository..."
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo

# Install Docker CE
info "Installing Docker CE..."
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Start and enable Docker
info "Starting Docker service..."
sudo systemctl start docker
sudo systemctl enable docker

# Add user to docker group
info "Adding $USER to docker group..."
sudo usermod -aG docker "$USER"

info "Docker CE installed successfully"
docker --version
warn "You may need to log out and back in for docker group membership to take effect"
