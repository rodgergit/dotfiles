# Paths

path=(
    $path                           # Keep existing PATH entries
    /usr/local/bin
    /usr/bin
    /bin
    /usr/sbin
    /sbin
    $HOME/.console-ninja/.bin
    $HOME/.composer/vendor/bin
    /opt/homebrew/bin
    /opt/homebrew/sbin
    $HOME/Library/Android/sdk/platform-tools
)

# Remove duplicate entries and non-existent directories
typeset -U path
path=($^path(N-/))

export PATH

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source <(fzf --zsh)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Prompt

fpath+=("$(brew --prefix)/share/zsh/site-functions")
autoload -U promptinit; promptinit
prompt pure


# Alias

alias art="php artisan"