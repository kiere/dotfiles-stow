# Dotfiles Install Scripts

Scripts for bootstrapping a fresh Fedora COSMIC installation.

## Quick Start

On a fresh install:

```bash
sudo dnf install -y git
git clone https://github.com/kiere/dotfiles-stow.git ~/dotfiles
cd ~/dotfiles/scripts
./install.sh
```

## Selective Installation

Run individual installers directly:

```bash
./installers/install-ide.sh
./installers/install-ruby.sh
```

Or use flags with the master script:

```bash
./install.sh --dev --ide      # Dev tools and IDE setup
./install.sh --ruby --rails   # Ruby and Rails only
./install.sh --help           # Show all options
```

## Script Overview

| Script | Purpose |
|--------|---------|
| `install-stow.sh` | Install stow and apply all dotfile configs |
| `install-homebrew.sh` | Homebrew (for lazydocker, Codex, etc.) |
| `install-dev-tools.sh` | Build essentials, compilers, libraries |
| `install-ide.sh` | Neovim, LazyVim deps, lazygit, lazydocker |
| `install-mise.sh` | Mise version manager |
| `install-ruby.sh` | Ruby 4.0 + 3.4.x via mise |
| `install-python.sh` | Python 3 (latest) via mise |
| `install-bun.sh` | Bun JavaScript runtime via mise |
| `install-elixir.sh` | Elixir + Phoenix via mise |
| `install-rails.sh` | Rails gem |
| `install-docker.sh` | Docker CE |
| `install-podman.sh` | Podman + podman-compose |
| `install-postgres-client.sh` | PostgreSQL client (psql) |
| `install-apps.sh` | VSCode, Zen Browser, Brave, 1Password |
| `install-fonts.sh` | Cascadia Code, Nerd Font Symbols |
| `install-cli-tools.sh` | btop, fastfetch |
| `install-ai-tools.sh` | Claude Code, OpenAI Codex |

## Design Principles

- **Idempotent**: All scripts are safe to run multiple times
- **Native packages preferred**: RPM packages over Flatpak where available
- **Minimal npm**: AI tools installed via curl/Homebrew, not npm
- **Homebrew for gaps**: Only used when necessary (lazydocker, Codex)
- **Mise for runtimes**: Ruby, Python, Elixir, Bun all managed by mise

## Dependencies

Scripts have the following dependencies:

```
install-stow.sh         → (none, runs first)
install-homebrew.sh     → (none)
install-dev-tools.sh    → (none)
install-ide.sh          → install-homebrew.sh (for lazydocker)
install-mise.sh         → (none)
install-ruby.sh         → install-mise.sh, install-dev-tools.sh
install-python.sh       → install-mise.sh
install-bun.sh          → install-mise.sh
install-elixir.sh       → install-mise.sh, install-dev-tools.sh
install-rails.sh        → install-ruby.sh
install-docker.sh       → (none)
install-podman.sh       → (none)
install-postgres-client.sh → (none)
install-apps.sh         → (none)
install-fonts.sh        → (none)
install-cli-tools.sh    → (none)
install-ai-tools.sh     → install-homebrew.sh (for Codex)
```

The master `install.sh` runs them in the correct order.
