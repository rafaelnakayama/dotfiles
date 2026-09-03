# dotfiles

```sh
git clone --recurse-submodules <repo> ~/Code/dotfiles && cd ~/Code/dotfiles && ./install.sh
```

Already cloned without `--recurse-submodules`? Run
`git submodule update --init --recursive`.

`install.sh` detects the OS and symlinks `shared/` plus the matching profile
into `$HOME`. An existing real file is moved to `.bak` first.

| Path | Contents |
| --- | --- |
| `shared/` | git, ssh, Zed, vendored zsh plugins |
| `macos/` | zsh, Ghostty, Brewfile |
| `linux/` | zsh, Ghostty, Ptyxis terminal settings, `packages.sh` (apt + snap) |
| `archive/` | backups, never linked |

`linux/` doesn't mirror `macos/` 1:1: no Homebrew, so `packages.sh` is a
standalone script (run manually, like `brew bundle` on macOS) that also
installs zsh itself; and `ptyxis/settings.dconf` (GNOME's default
terminal, kept alongside Ghostty) is loaded by `install.sh` via
`dconf load` since its settings live in dconf, not a plain config file.

`linux/xdg-terminals.list` makes `Ctrl+Alt+T` and other `xdg-terminal-exec`
callers launch Ghostty instead of Ptyxis (GNOME's `x-terminal-emulator`
alternative still points to Ptyxis, kept as the listed fallback).

`shared/zsh-plugins/` vendors `zsh-autosuggestions` and
`zsh-syntax-highlighting` as git submodules (pinned commits, not a package
manager), so both zsh profiles source the same version on any machine.

`.gitignore` is an allowlist: `/*` ignores everything, each `!` opens one
exception, so nothing is committed by accident.

No credentials here. `archive/vscode/settings.json` is sanitized, with the
`mssql` connection profiles stripped.
