#!/usr/bin/env bash
# Fonts the shared configs ask for by name. Run manually: ./packages/fonts.sh
# Split out of packages.sh so an already-provisioned machine can pick up a new
# font without replaying the apt and snap installs.
set -euo pipefail

# Comic Mono: not in apt, and the shared Ghostty config asks for it by name,
# so without this the font silently falls back on Linux.
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"
for f in ComicMono.ttf ComicMono-Bold.ttf; do
  curl -fsSL -o "$FONT_DIR/$f" "https://dtinth.github.io/comic-mono-font/$f"
done
fc-cache -f "$FONT_DIR"
