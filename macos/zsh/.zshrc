export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"

alias python3=/opt/homebrew/bin/python3.13
alias pip3=/opt/homebrew/bin/pip3.13
alias rm="rm -i"

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# must stay last
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
