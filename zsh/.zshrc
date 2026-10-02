alias rm="rm -i"

# Only the alanpeabody prompt from oh-my-zsh, not the framework: no aliases,
# no auto_cd, no completion or history changes. These are the two library
# files the theme calls into, plus what oh-my-zsh.sh would have set up for it.
ZSH="$HOME/Code/dotfiles/zsh/oh-my-zsh"
autoload -U colors is-at-least && colors
setopt prompt_subst
# the async git prompt needs more of the framework; the plain one does not
zstyle ':omz:alpha:lib:git' async-prompt no
source "$ZSH/lib/git.zsh"
source "$ZSH/lib/prompt_info_functions.zsh"
source "$ZSH/themes/alanpeabody.zsh-theme"

source "$HOME/Code/dotfiles/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
# must stay last
source "$HOME/Code/dotfiles/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
