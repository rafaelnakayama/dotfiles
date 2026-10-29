#!/usr/bin/env bash
set -euo pipefail

DOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Each tool has its own directory holding the Linux version of its files.
# Where macOS differs, the variant lives in a macos/ directory inside it.
case "$(uname -s)" in
  Darwin) OS=macos; VARIANT=/macos ;;
  Linux)  OS=linux; VARIANT= ;;
  *) echo "unsupported OS: $(uname -s)" >&2; exit 1 ;;
esac

link() {
  [ -e "$1" ] || return 0
  mkdir -p "$(dirname "$2")"
  if [ -e "$2" ] && [ ! -L "$2" ]; then mv "$2" "$2.bak"; fi
  ln -sfn "$1" "$2"
  echo "  $2"
}

link "$DOT/git/.gitconfig"           "$HOME/.gitconfig"
link "$DOT/ssh/config"               "$HOME/.ssh/config"
link "$DOT/ghostty/config"           "$HOME/.config/ghostty/config"
link "$DOT/tmux/tmux.conf"           "$HOME/.config/tmux/tmux.conf"
link "$DOT/tmux/plugins"             "$HOME/.config/tmux/plugins"
link "$DOT/starship/starship.toml"   "$HOME/.config/starship.toml"
link "$DOT/nvim"                     "$HOME/.config/nvim"
link "$DOT/ghostty$VARIANT/os.conf"  "$HOME/.config/ghostty/os.conf"
link "$DOT/zsh$VARIANT/.zshrc"       "$HOME/.zshrc"
link "$DOT/zsh$VARIANT/.zprofile"    "$HOME/.zprofile"

if [ "$OS" = linux ]; then
  link "$DOT/misc/xdg/xdg-terminals.list" "$HOME/.config/xdg-terminals.list"
fi

# Caps Lock <-> Escape swap; runs at each login (GNOME's is in keybindings.dconf)
if [ "$OS" = macos ]; then
  link "$DOT/misc/launchd/macos/local.swap-caps-escape.plist" \
       "$HOME/Library/LaunchAgents/local.swap-caps-escape.plist"
fi

if [ "$OS" = linux ] && [ -f "$DOT/misc/ptyxis/settings.dconf" ] && command -v dconf >/dev/null; then
  dconf load /org/gnome/Ptyxis/ < "$DOT/misc/ptyxis/settings.dconf"
  echo "  dconf: org.gnome.Ptyxis"
fi

# GNOME shortcuts that mirror macOS ones
if [ "$OS" = linux ] && command -v dconf >/dev/null; then
  dconf load /org/gnome/ < "$DOT/misc/gnome/keybindings.dconf"
  echo "  dconf: GNOME keybindings"
fi
