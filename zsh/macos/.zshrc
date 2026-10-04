export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"

alias python3=/opt/homebrew/bin/python3.13
alias pip3=/opt/homebrew/bin/pip3.13

alias rm="rm -i"

# Prompt: config is starship/starship.toml, shared by both machines.
eval "$(starship init zsh)"

source "$HOME/Code/dotfiles/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
# must stay last
source "$HOME/Code/dotfiles/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
