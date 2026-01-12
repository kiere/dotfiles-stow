#!/usr/bin/env bash
# Master install script for Fedora COSMIC dotfiles
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALLERS_DIR="$SCRIPT_DIR/installers"
source "$INSTALLERS_DIR/lib/helpers.sh"

# All available installer scripts in order
ALL_SCRIPTS=(
  "install-stow.sh"
  "install-homebrew.sh"
  "install-dev-tools.sh"
  "install-ide.sh"
  "install-mise.sh"
  "install-ruby.sh"
  "install-python.sh"
  "install-bun.sh"
  "install-elixir.sh"
  "install-rails.sh"
  "install-docker.sh"
  "install-podman.sh"
  "install-postgres-client.sh"
  "install-apps.sh"
  "install-fonts.sh"
  "install-cli-tools.sh"
  "install-ai-tools.sh"
)

# Map flags to scripts
declare -A FLAG_MAP=(
  ["--stow"]="install-stow.sh"
  ["--homebrew"]="install-homebrew.sh"
  ["--dev"]="install-dev-tools.sh"
  ["--ide"]="install-ide.sh"
  ["--mise"]="install-mise.sh"
  ["--ruby"]="install-ruby.sh"
  ["--python"]="install-python.sh"
  ["--bun"]="install-bun.sh"
  ["--elixir"]="install-elixir.sh"
  ["--rails"]="install-rails.sh"
  ["--docker"]="install-docker.sh"
  ["--podman"]="install-podman.sh"
  ["--postgres"]="install-postgres-client.sh"
  ["--apps"]="install-apps.sh"
  ["--fonts"]="install-fonts.sh"
  ["--cli"]="install-cli-tools.sh"
  ["--ai"]="install-ai-tools.sh"
)

usage() {
  cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Bootstrap a fresh Fedora COSMIC installation with dotfiles and tools.

Options:
  (no args)     Run all installers
  --stow        Install stow and apply dotfile configs
  --homebrew    Install Homebrew
  --dev         Install development tools and build dependencies
  --ide         Install Neovim, LazyVim deps, lazygit, lazydocker
  --mise        Install mise version manager
  --ruby        Install Ruby 4.0 + 3.4.x via mise
  --python      Install Python 3 (latest) via mise
  --bun         Install Bun JavaScript runtime via mise
  --elixir      Install Elixir + Phoenix via mise
  --rails       Install Rails gem
  --docker      Install Docker CE
  --podman      Install Podman
  --postgres    Install PostgreSQL client
  --apps        Install desktop apps (VSCode, Brave, etc.)
  --fonts       Install fonts (Cascadia Code, Nerd Fonts)
  --cli         Install CLI tools (btop, fastfetch)
  --ai          Install AI coding tools (Claude Code, Codex)
  --help        Show this help message

Examples:
  $(basename "$0")                  # Run all installers
  $(basename "$0") --dev --ide      # Just dev tools and IDE setup
  $(basename "$0") --ruby --rails   # Just Ruby and Rails
EOF
}

run_script() {
  local script="$1"
  section "Running $script"
  "$INSTALLERS_DIR/$script"
}

main() {
  local scripts_to_run=()

  # Parse arguments
  if [[ $# -eq 0 ]]; then
    # No arguments: run all scripts
    scripts_to_run=("${ALL_SCRIPTS[@]}")
  else
    for arg in "$@"; do
      case "$arg" in
        --help|-h)
          usage
          exit 0
          ;;
        --*)
          if [[ -v "FLAG_MAP[$arg]" ]]; then
            scripts_to_run+=("${FLAG_MAP[$arg]}")
          else
            error "Unknown option: $arg"
          fi
          ;;
        *)
          error "Unknown argument: $arg"
          ;;
      esac
    done
  fi

  if [[ ${#scripts_to_run[@]} -eq 0 ]]; then
    error "No scripts to run"
  fi

  echo "============================================"
  echo "  Fedora COSMIC Dotfiles Installer"
  echo "============================================"
  echo ""
  info "Will run ${#scripts_to_run[@]} installer(s)"
  echo ""

  for script in "${scripts_to_run[@]}"; do
    run_script "$script"
  done

  echo ""
  echo "============================================"
  info "Installation complete!"
  echo "============================================"
  echo ""
  info "You may need to log out and back in for all changes to take effect."
}

main "$@"
