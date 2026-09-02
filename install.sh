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
link "$DOT/$OS_DIR/zsh/.zshrc"       "$HOME/.zshrc"
link "$DOT/$OS_DIR/zsh/.zprofile"    "$HOME/.zprofile"
link "$DOT/$OS_DIR/ghostty/config"   "$HOME/.config/ghostty/config"
