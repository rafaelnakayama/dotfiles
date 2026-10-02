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
link "$DOT/zed/settings.json"        "$HOME/.config/zed/settings.json"
link "$DOT/zed/keymap.json"          "$HOME/.config/zed/keymap.json"
link "$DOT/ghostty/config"           "$HOME/.config/ghostty/config"
link "$DOT/tmux/tmux.conf"           "$HOME/.config/tmux/tmux.conf"
link "$DOT/tmux/plugins"             "$HOME/.config/tmux/plugins"
link "$DOT/ghostty$VARIANT/os.conf"  "$HOME/.config/ghostty/os.conf"
link "$DOT/zsh$VARIANT/.zshrc"       "$HOME/.zshrc"
link "$DOT/zsh$VARIANT/.zprofile"    "$HOME/.zprofile"

if [ "$OS" = linux ]; then
  link "$DOT/xdg/xdg-terminals.list" "$HOME/.config/xdg-terminals.list"
fi

if [ "$OS" = linux ] && [ -f "$DOT/ptyxis/settings.dconf" ] && command -v dconf >/dev/null; then
  dconf load /org/gnome/Ptyxis/ < "$DOT/ptyxis/settings.dconf"
  echo "  dconf: org.gnome.Ptyxis"
fi

# GNOME's own "launch terminal" shortcut, moved off Ctrl+Alt+T so it matches
# the Ctrl+Cmd+N global hotkey on macOS. xdg-terminals.list points it at Ghostty.
MEDIA_KEYS=org.gnome.settings-daemon.plugins.media-keys
if [ "$OS" = linux ] && command -v gsettings >/dev/null &&
   gsettings list-keys "$MEDIA_KEYS" 2>/dev/null | grep -qx terminal; then
  gsettings set "$MEDIA_KEYS" terminal "['<Control><Alt>n']"
  echo "  gsettings: launch terminal = Ctrl+Alt+N"
fi
