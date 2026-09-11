# dotfiles

```sh
git clone git@github.com:rafaelnakayama/dotfiles.git ~/Code/dotfiles && cd ~/Code/dotfiles && ./install.sh
```

`install.sh` symlinks `shared/` plus the profile for the current OS into `$HOME`,
moving any pre-existing real file to `.bak`.

| Path | Contents |
| --- | --- |
| `shared/` | git, ssh, Zed, Ghostty |
| `macos/` | zsh, Brewfile |
| `linux/` | zsh |
| `archive/` | backups, never linked |

`.gitignore` is an allowlist: a new file needs its own `!` line or it is not committed.

No credentials here; `archive/vscode/settings.json` has the `mssql` profiles stripped.
