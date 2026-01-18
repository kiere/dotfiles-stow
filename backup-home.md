# Backup Home Directory to USB

## Check USB mount location

```bash
lsblk -o NAME,MOUNTPOINT
```

## Copy everything except Dropbox

```bash
rsync -avh --progress --exclude='Dropbox' ~/ /run/media/kiere/YOUR_USB/omarchy-backup/
```

Replace `YOUR_USB` with the actual mount name from the `lsblk` output.

## Notes

- `-a` preserves permissions, symlinks, timestamps
- `-v` verbose output
- `-h` human-readable sizes
- `--progress` shows transfer progress
- Trailing `/` on source copies contents, not the folder itself
