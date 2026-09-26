# dotfiles

One repo for two machines: `install.sh` links `shared/` everywhere and adds
`macos/` or `linux/` on top, depending on the OS it is run on.

```sh
git clone --recurse-submodules git@github.com:rafaelnakayama/dotfiles.git ~/Code/dotfiles && cd ~/Code/dotfiles && ./install.sh
```

Cloned without `--recurse-submodules`? Run `git submodule update --init --recursive`.

`install.sh` links configs only. Install the packages separately: `brew bundle`
on macOS, `linux/packages.sh` on Ubuntu.

On Ubuntu the shared Ghostty config asks for Comic Mono by name, which apt does
not carry; without it the font silently falls back. `linux/packages.sh` installs
it, or run `linux/fonts.sh` on its own to add fonts to a machine that is already
set up.
