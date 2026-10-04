alias rm="rm -i"

# Prompt: config is starship/starship.toml, shared by both machines.
eval "$(starship init zsh)"

source "$HOME/Code/dotfiles/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
# must stay last
source "$HOME/Code/dotfiles/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
