#!/usr/bin/env bash
# Install desktop applications
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Installing VSCode"

if ! is_installed code; then
  info "Adding Microsoft VSCode repository..."
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null

  info "Installing VSCode..."
  sudo dnf install -y code
else
  info "VSCode already installed"
fi

section "Installing Brave Browser"

if ! is_installed brave-browser; then
  info "Adding Brave repository..."
  sudo dnf install -y dnf-plugins-core
  sudo dnf config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
  sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

  info "Installing Brave..."
  sudo dnf install -y brave-browser
else
  info "Brave already installed"
fi

section "Installing Zen Browser"

# Zen Browser is only available as Flatpak
if ! flatpak list --system 2>/dev/null | grep -q "app.zen_browser.zen"; then
  info "Installing Zen Browser via Flatpak..."
  sudo flatpak install --system -y flathub app.zen_browser.zen
else
  info "Zen Browser already installed"
fi

section "Installing 1Password"

if ! is_installed 1password; then
  info "Adding 1Password repository..."
  sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
  echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://downloads.1password.com/linux/keys/1password.asc" | sudo tee /etc/yum.repos.d/1password.repo > /dev/null

  info "Installing 1Password..."
  sudo dnf install -y 1password
else
  info "1Password already installed"
fi

section "Installing Signal"

# Signal - encrypted messaging (Flatpak)
if ! flatpak list --system 2>/dev/null | grep -q "org.signal.Signal"; then
  info "Installing Signal via Flatpak..."
  sudo flatpak install --system -y flathub org.signal.Signal
else
  info "Signal already installed"
fi

section "Installing Spotify"

# Spotify - music streaming (Flatpak)
if ! flatpak list --system 2>/dev/null | grep -q "com.spotify.Client"; then
  info "Installing Spotify via Flatpak..."
  sudo flatpak install --system -y flathub com.spotify.Client
else
  info "Spotify already installed"
fi

section "Installing LocalSend"

# LocalSend - cross-platform AirDrop alternative (Flatpak)
if ! flatpak list --system 2>/dev/null | grep -q "org.localsend.localsend_app"; then
  info "Installing LocalSend via Flatpak..."
  sudo flatpak install --system -y flathub org.localsend.localsend_app
else
  info "LocalSend already installed"
fi

section "Installing image and document viewers"

# Pinta - simple image editor (like Paint.NET)
dnf_install pinta

# Evince - PDF/document viewer
dnf_install evince

section "Installing OBS Studio"

# OBS Studio - streaming and screen recording
dnf_install obs-studio

section "Installing Cursor"

# Cursor - AI-first code editor (RPM)
if ! is_installed cursor; then
  info "Installing Cursor..."
  sudo dnf install -y "https://api2.cursor.sh/updates/download/golden/linux-x64-rpm/cursor/2.3"
else
  info "Cursor already installed"
fi

info "Desktop applications installed successfully"
