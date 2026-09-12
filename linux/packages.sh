#!/usr/bin/env bash
# Package list for a fresh Ubuntu install. Run manually: ./linux/packages.sh
set -euo pipefail

sudo install -m 0755 -d /etc/apt/keyrings

# Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# GitHub CLI
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
  | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

# Google Chrome
curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main" \
  | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null

sudo apt-get update
sudo apt-get install -y \
  docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
  gh \
  git \
  ghostty \
  google-chrome-stable \
  openjdk-21-jdk \
  python3-pip python3-venv \
  ripgrep \
  vlc \
  zsh

sudo usermod -aG docker "$USER"

# Snap store apps (GUI, not available as .deb)
sudo snap install code --classic
sudo snap install dbeaver-ce
sudo snap install discord
sudo snap install drawio
sudo snap install firefox
sudo snap install spotify
sudo snap install steam

# Comic Mono: not in apt, and the shared Ghostty config asks for it by name,
# so without this the font silently falls back on Linux.
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"
for f in ComicMono.ttf ComicMono-Bold.ttf; do
  curl -fsSL -o "$FONT_DIR/$f" "https://dtinth.github.io/comic-mono-font/$f"
done
fc-cache -f "$FONT_DIR"
