#!/usr/bin/env bash
set -euo pipefail

DOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

case "$(uname -s)" in
  Darwin) OS_DIR=macos ;;
  Linux)  OS_DIR=linux ;;
  *) echo "unsupported OS: $(uname -s)" >&2; exit 1 ;;
esac

link() {
  [ -e "$1" ] || return 0
  mkdir -p "$(dirname "$2")"
  if [ -e "$2" ] && [ ! -L "$2" ]; then mv "$2" "$2.bak"; fi
  ln -sfn "$1" "$2"
  echo "  $2"
}

link "$DOT/shared/git/.gitconfig"    "$HOME/.gitconfig"
link "$DOT/shared/ssh/config"        "$HOME/.ssh/config"
link "$DOT/shared/zed/settings.json" "$HOME/.config/zed/settings.json"
link "$DOT/shared/zed/keymap.json"   "$HOME/.config/zed/keymap.json"
link "$DOT/shared/ghostty/config"    "$HOME/.config/ghostty/config"
link "$DOT/shared/tmux/tmux.conf"    "$HOME/.config/tmux/tmux.conf"
link "$DOT/shared/tmux/plugins"      "$HOME/.config/tmux/plugins"
link "$DOT/$OS_DIR/ghostty/os.conf"  "$HOME/.config/ghostty/os.conf"
link "$DOT/$OS_DIR/zsh/.zshrc"       "$HOME/.zshrc"
link "$DOT/$OS_DIR/zsh/.zprofile"    "$HOME/.zprofile"
link "$DOT/$OS_DIR/xdg-terminals.list" "$HOME/.config/xdg-terminals.list"

if [ "$OS_DIR" = linux ] && [ -f "$DOT/linux/ptyxis/settings.dconf" ] && command -v dconf >/dev/null; then
  dconf load /org/gnome/Ptyxis/ < "$DOT/linux/ptyxis/settings.dconf"
  echo "  dconf: org.gnome.Ptyxis"
fi

# GNOME's own "launch terminal" shortcut, moved off Ctrl+Alt+T so it matches
# the Ctrl+Cmd+N global hotkey on macOS. xdg-terminals.list points it at Ghostty.
MEDIA_KEYS=org.gnome.settings-daemon.plugins.media-keys
if [ "$OS_DIR" = linux ] && command -v gsettings >/dev/null &&
   gsettings list-keys "$MEDIA_KEYS" 2>/dev/null | grep -qx terminal; then
  gsettings set "$MEDIA_KEYS" terminal "['<Control><Alt>n']"
  echo "  gsettings: launch terminal = Ctrl+Alt+N"
fi
