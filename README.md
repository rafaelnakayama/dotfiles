# dotfiles

```sh
git clone <repo> ~/Code/dotfiles && cd ~/Code/dotfiles && ./install.sh
```

`install.sh` detects the OS and symlinks `shared/` plus the matching profile
into `$HOME`. An existing real file is moved to `.bak` first.

| Path | Contents |
| --- | --- |
| `shared/` | git, ssh, Zed, Ghostty |
| `macos/` | zsh, Brewfile |
| `linux/` | zsh, Ubuntu machine |
| `archive/` | backups, never linked |

`.gitignore` is an allowlist: `/*` ignores everything, each `!` opens one
exception, so nothing is committed by accident.

No credentials here. `archive/vscode/settings.json` is sanitized, with the
`mssql` connection profiles stripped.
