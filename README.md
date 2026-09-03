# dotfiles

```sh
git clone <repo> ~/Code/dotfiles && cd ~/Code/dotfiles && ./install.sh
```

`install.sh` detects the OS and symlinks `shared/` plus the matching profile
into `$HOME`. An existing real file is moved to `.bak` first.

| Path | Contents |
| --- | --- |
| `shared/` | git, ssh, Zed |
| `macos/` | zsh, Ghostty, Brewfile |
| `linux/` | Ghostty, Ptyxis terminal settings, `packages.sh` (apt + snap) |
| `archive/` | backups, never linked |

Ubuntu machine runs stock bash (no zsh), so `linux/` doesn't mirror
`macos/` 1:1: there's no `zsh/` profile, `packages.sh` is a standalone
script (run manually, like `brew bundle` on macOS), and
`ptyxis/settings.dconf` (GNOME's default terminal, kept alongside
Ghostty) is loaded by `install.sh` via `dconf load` since its settings
live in dconf, not a plain config file.

`linux/xdg-terminals.list` makes `Ctrl+Alt+T` and other `xdg-terminal-exec`
callers launch Ghostty instead of Ptyxis (GNOME's `x-terminal-emulator`
alternative still points to Ptyxis, kept as the listed fallback).

`.gitignore` is an allowlist: `/*` ignores everything, each `!` opens one
exception, so nothing is committed by accident.

No credentials here. `archive/vscode/settings.json` is sanitized, with the
`mssql` connection profiles stripped.
