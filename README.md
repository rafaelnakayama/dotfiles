# dotfiles

```sh
git clone --recurse-submodules git@github.com:rafaelnakayama/dotfiles.git ~/Code/dotfiles && cd ~/Code/dotfiles && ./install.sh
```

Cloned without `--recurse-submodules`? Run `git submodule update --init --recursive`.

`install.sh` symlinks `shared/` plus the profile for the current OS into `$HOME`,
moving any pre-existing real file to `.bak`.

| Path | Contents |
| --- | --- |
| `shared/` | git, ssh, Zed, Ghostty, vendored zsh plugins |
| `macos/` | zsh, Brewfile |
| `linux/` | zsh, Ptyxis settings, `xdg-terminals.list`, `packages.sh` |
| `archive/` | backups, never linked |

Packages are installed by hand: `brew bundle` on macOS, `linux/packages.sh`
(apt + snap) on Ubuntu, which has no Homebrew.

Linux only: `ptyxis/settings.dconf` is loaded by `install.sh` through `dconf load`,
since GNOME keeps those settings in dconf, and `xdg-terminals.list` points
`Ctrl+Alt+T` at Ghostty instead of Ptyxis.

`shared/zsh-plugins/` pins both zsh plugins as submodules so every machine sources
the same version. `.gitignore` is an allowlist: a new file needs its own `!` line
or it is not committed.

No credentials here; `archive/vscode/settings.json` has the `mssql` profiles stripped.
