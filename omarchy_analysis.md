# Omarchy Feature Analysis for Fedora Migration

This document analyzes tools, apps, and features from Omarchy to identify what you may want to add to your Fedora COSMIC setup.

## Legend

- ✅ **Already have** - In your Fedora scripts
- ⭐ **Recommended** - Worth adding
- 🤔 **Consider** - Nice to have, evaluate need
- ❌ **Skip** - Hyprland/Arch-specific or not needed

---

## CLI Tools & Utilities

| Tool | Omarchy | Your Scripts | Action |
|------|---------|--------------|--------|
| `bat` | ✓ | ❌ | ⭐ Add - better `cat` with syntax highlighting |
| `eza` | ✓ | ❌ | ⭐ Add - modern `ls` replacement |
| `fd` | ✓ | ✓ (fd-find) | ✅ Have it |
| `ripgrep` | ✓ | ✓ | ✅ Have it |
| `fzf` | ✓ | ✓ | ✅ Have it |
| `zoxide` | ✓ | ❌ | ⭐ Add - smarter `cd` with frecency |
| `tldr` | ✓ | ❌ | ⭐ Add - simplified man pages |
| `dust` | ✓ | ❌ | 🤔 Consider - better `du` visualization |
| `btop` | ✓ | ✓ | ✅ Have it |
| `fastfetch` | ✓ | ✓ | ✅ Have it |
| `jq` | ✓ | ❌ | ⭐ Add - JSON processor (essential) |
| `yq` | ✓ | ❌ | 🤔 Consider - YAML processor |
| `gum` | ✓ | ❌ | 🤔 Consider - glamorous shell scripts |
| `starship` | ✓ | ❌ | 🤔 Consider - cross-shell prompt |
| `inxi` | ✓ | ❌ | 🤔 Consider - system info tool |

## Development Tools

| Tool | Omarchy | Your Scripts | Action |
|------|---------|--------------|--------|
| `mise` | ✓ | ✓ | ✅ Have it |
| `lazygit` | ✓ | ✓ | ✅ Have it |
| `lazydocker` | ✓ | ✓ | ✅ Have it |
| `docker` | ✓ | ✓ | ✅ Have it |
| `github-cli` (gh) | ✓ | ❌ | ⭐ Add - GitHub from terminal |
| `tree-sitter-cli` | ✓ | ❌ | 🤔 Consider - for nvim grammar |

## Docker Development Databases

Omarchy provides one-click Docker database setup. **⭐ Recommended to add similar script.**

```bash
# PostgreSQL (dev mode, no password)
docker run -d --restart unless-stopped -p "127.0.0.1:5432:5432" \
  --name=postgres18 -e POSTGRES_HOST_AUTH_METHOD=trust postgres:18

# MySQL (dev mode, empty password)
docker run -d --restart unless-stopped -p "127.0.0.1:3306:3306" \
  --name=mysql8 -e MYSQL_ROOT_PASSWORD= -e MYSQL_ALLOW_EMPTY_PASSWORD=true mysql:8.4

# Redis
docker run -d --restart unless-stopped -p "127.0.0.1:6379:6379" \
  --name=redis redis:7
```

## AI/Coding Assistants

| Tool | Omarchy | Your Scripts | Action |
|------|---------|--------------|--------|
| Claude Code | ✓ | ✓ | ✅ Have it |
| OpenAI Codex | ✓ | ✓ | ✅ Have it |
| GitHub Copilot CLI | ✓ | ❌ | 🤔 Consider |
| Ollama | ✓ | ❌ | 🤔 Consider - local LLMs |
| LM Studio | ✓ | ❌ | 🤔 Consider - local LLM GUI |

## Editors

| Tool | Omarchy | Your Scripts | Action |
|------|---------|--------------|--------|
| Neovim (LazyVim) | ✓ | ✓ | ✅ Have it |
| VSCode | ✓ | ✓ | ✅ Have it |
| Cursor | ✓ | ❌ | 🤔 Consider - AI-first editor |
| Zed | ✓ | ❌ | 🤔 Consider - fast Rust editor |
| Helix | ✓ | ❌ | 🤔 Consider - modal editor |

## Desktop Apps

| App | Omarchy | Your Scripts | Action |
|-----|---------|--------------|--------|
| 1Password | ✓ | ✓ | ✅ Have it |
| 1Password CLI | ✓ | ❌ | ⭐ Add - `op` command |
| Brave | ✓ (Chromium) | ✓ | ✅ Have it |
| Zen Browser | ❌ | ✓ | ✅ Have it |
| Obsidian | ✓ | ❌ (use sync) | ✅ Using Obsidian Sync |
| Signal | ✓ | ❌ | 🤔 Consider - encrypted messaging |
| Spotify | ✓ | ❌ | 🤔 Consider |
| OBS Studio | ✓ | ❌ | 🤔 Consider - streaming/recording |
| Kdenlive | ✓ | ❌ | 🤔 Consider - video editing |
| LibreOffice | ✓ | ❌ | 🤔 Consider |
| LocalSend | ✓ | ❌ | ⭐ Add - AirDrop alternative |
| Pinta | ✓ | ❌ | 🤔 Consider - simple image editor |
| Evince | ✓ | ❌ | 🤔 Consider - PDF viewer |

## Cloud/Services

| Service | Omarchy | Your Scripts | Action |
|---------|---------|--------------|--------|
| Dropbox | ✓ | ✓ | ✅ Have it |
| Tailscale | ✓ | ❌ | ⭐ Add - mesh VPN |
| Bitwarden | ✓ | ❌ | ❌ Skip - using 1Password |

## System Tools

| Tool | Omarchy | Your Scripts | Action |
|------|---------|--------------|--------|
| Snapper | ✓ | ✓ | ✅ Have it |
| UFW (firewall) | ✓ | ❌ | 🤔 Consider |
| Printing (CUPS) | ✓ | ❌ | ⭐ Add if you have printers |

## Fonts

| Font | Omarchy | Your Scripts | Action |
|------|---------|--------------|--------|
| Cascadia Code/Mono Nerd | ✓ | ✓ | ✅ Have it |
| JetBrains Mono Nerd | ✓ | ❌ | 🤔 Consider |
| Noto Fonts (CJK, emoji) | ✓ | ❌ | ⭐ Add - Unicode coverage |

## Gaming

| Tool | Omarchy | Your Scripts | Action |
|------|---------|--------------|--------|
| Steam | ✓ | ❌ | 🤔 If you game |
| Xbox Controller support | ✓ | ❌ | 🤔 If you use Xbox controllers |

## Omarchy-Specific (Skip for Fedora COSMIC)

These are Hyprland/Arch-specific and not applicable:

- ❌ Hyprland, Hypridle, Hyprlock, Hyprsunset
- ❌ Walker (launcher) - COSMIC has its own
- ❌ Waybar - COSMIC has its own panel
- ❌ SDDM - COSMIC has its own login
- ❌ Mako - COSMIC has notifications
- ❌ All `omarchy-*` scripts
- ❌ yay (AUR helper) - Fedora uses dnf/COPR

---

## Recommended Additions to Your Scripts

### High Priority (⭐)

1. **`install-cli-essentials.sh`** - Add these to your cli-tools installer:
   ```bash
   dnf install -y bat eza zoxide tldr jq
   ```

2. **`install-github-cli.sh`**:
   ```bash
   dnf install -y gh
   ```

3. **`install-1password-cli.sh`**:
   ```bash
   # Already have 1password repo
   dnf install -y 1password-cli
   ```

4. **`install-docker-dbs.sh`** - Docker database containers for dev

5. **`install-localsend.sh`** - Cross-platform file sharing (AirDrop alternative)
   ```bash
   flatpak install -y flathub org.localsend.localsend_app
   ```

6. **`install-tailscale.sh`** - Mesh VPN
   ```bash
   dnf config-manager --add-repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo
   dnf install -y tailscale
   sudo systemctl enable --now tailscaled
   ```

7. **`install-noto-fonts.sh`** - Unicode/emoji coverage
   ```bash
   dnf install -y google-noto-fonts-common google-noto-emoji-fonts \
     google-noto-sans-cjk-fonts
   ```

### Medium Priority (🤔)

- Ollama for local LLMs
- Signal for encrypted messaging
- OBS Studio if you stream/record
- Cursor/Zed if you want to try new editors

---

## Summary

**Your Fedora scripts already cover:**
- Core dev tools (mise, lazygit, lazydocker, docker, neovim)
- Languages (Ruby, Python, Elixir, Bun)
- Browsers (Brave, Zen)
- AI tools (Claude Code, Codex)
- System snapshots (Snapper)
- Cloud storage (Dropbox)
- Password manager (1Password)

**Top gaps to fill:**
1. CLI enhancements: `bat`, `eza`, `zoxide`, `tldr`, `jq`
2. GitHub CLI (`gh`)
3. 1Password CLI (`op`)
4. Docker dev databases
5. LocalSend (AirDrop alternative)
6. Tailscale (mesh VPN)
7. Noto fonts (Unicode/emoji)

**Safe to ignore:**
- All Hyprland-specific tools (you have COSMIC)
- Arch-specific packages (yay, AUR)
- Alternative password managers (you use 1Password)
