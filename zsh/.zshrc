export ZSH="$HOME/Code/dotfiles/zsh/oh-my-zsh"
# custom plugins are looked up in $ZSH_CUSTOM/plugins, i.e. zsh/plugins
ZSH_CUSTOM="$HOME/Code/dotfiles/zsh"
ZSH_THEME="alanpeabody"
# pinned as a submodule; update it with git, not by itself
zstyle ':omz:update' mode disabled
# zsh-syntax-highlighting must stay last
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source "$ZSH/oh-my-zsh.sh"

alias rm="rm -i"
