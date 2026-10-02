export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"

alias python3=/opt/homebrew/bin/python3.13
alias pip3=/opt/homebrew/bin/pip3.13

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
