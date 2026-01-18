# Backup Home Directory to USB

## Check USB mount location

```bash
lsblk -o NAME,MOUNTPOINT
```

## Copy everything except Dropbox and dotfiles

```bash
rsync -avh --progress --exclude='Dropbox' --exclude='dotfiles' ~/ /run/media/kiere/YOUR_USB/omarchy-backup/
```

Replace `YOUR_USB` with the actual mount name from the `lsblk` output.

## Multiple excludes

Add separate `--exclude` options for each pattern:

```bash
rsync -avh --progress --exclude='Dropbox' --exclude='dotfiles' --exclude='.cache' ~/  /run/media/kiere/YOUR_USB/omarchy-backup/
```

Or use an exclude file with `--exclude-from`:

```bash
rsync -avh --progress --exclude-from='exclude-list.txt' ~/ /run/media/kiere/YOUR_USB/omarchy-backup/
```

Where `exclude-list.txt` contains one pattern per line:

```
Dropbox
dotfiles
.cache
```

## Notes

- `-a` preserves permissions, symlinks, timestamps
- `-v` verbose output
- `-h` human-readable sizes
- `--progress` shows transfer progress
- Trailing `/` on source copies contents, not the folder itself
