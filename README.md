# dotfiles-stow

These are my dotfiles organized into Stow packages.

## Stow

```shell
sudo dnf install -y stow git
```


## Why the new repo?

After the move from macOS to Linux I noticed more conformity to the File Hierarchy Standard (FHS) in the Linux community.  Most config is located in `.config/` and other related files in `.local/share` and `.local/`.

Instead of restructuring all the macOS-based dotfiles into the new structure, I wanted to start fresh with new config and tools.  I'm using NeoVim with LazyVim, LazyGit and LazyDocker.

I've also focused more on Ruby on Rails development with Hotwire instead of Elixir and Phoenix with LiveView.
