# --- Path ---
path=(
  $path
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
typeset -U path
path=($^path(N-/))
export PATH

# --- Homebrew (used below) ---
BREW_PREFIX="${BREW_PREFIX:-$(brew --prefix 2>/dev/null)}"

# --- Zsh plugins ---
[[ -n "$BREW_PREFIX" && -f "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] &&
  source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[[ -n "$BREW_PREFIX" && -f "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] &&
  source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
(( $+commands[fzf] )) && source <(fzf --zsh)

# --- NVM ---
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && \. "$NVM_DIR/bash_completion"

# --- Prompt ---
[[ -n "$BREW_PREFIX" ]] && fpath+=("$BREW_PREFIX/share/zsh/site-functions")
autoload -U promptinit
promptinit
prompt pure 2>/dev/null || prompt off

# --- Aliases ---
alias art="php artisan"
alias cc="claude"

# --- Exports ---
export PHP_HOME=/opt/homebrew
export XDEBUG_MODE=coverage
