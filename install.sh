#!/usr/bin/env bash
set -e

# --- Config (single source of truth) ---
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Dotfiles to symlink: "repo_file" or "repo_file:target_path"
DOTFILES=(
  .zshrc
)

# Homebrew packages used by the dotfiles
HOMEBREW_PACKAGES=(
  zsh-syntax-highlighting
  zsh-autosuggestions
  fzf
  pure
)

# --- Helpers ---
link_dotfile() {
  local src="$DOTFILES_DIR/$1"
  local dest="${2:-$HOME/$1}"

  if [[ ! -e "$src" ]]; then
    echo "Warning: $src not found, skipping"
    return
  fi

  if [[ -L "$dest" ]]; then
    echo "Removing existing symlink: $dest"
    unlink "$dest"
  elif [[ -e "$dest" ]]; then
    echo "Error: $dest exists and is not a symlink. Move it and run again."
    exit 1
  fi

  ln -s "$src" "$dest"
  echo "Linked: $dest -> $src"
}

ensure_brew() {
  if command -v brew &>/dev/null; then
    return
  fi
  echo "Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
}

# --- Symlink dotfiles ---
echo "==> Linking dotfiles"
for entry in "${DOTFILES[@]}"; do
  if [[ "$entry" == *:* ]]; then
    link_dotfile "${entry%%:*}" "${entry#*:}"
  else
    link_dotfile "$entry"
  fi
done

# --- Homebrew and packages ---
echo "==> Homebrew and packages"
ensure_brew
for pkg in "${HOMEBREW_PACKAGES[@]}"; do
  if brew list "$pkg" &>/dev/null; then
    echo "  $pkg (already installed)"
  else
    echo "  Installing $pkg..."
    brew install "$pkg"
  fi
done

echo ""
echo "Done. Run 'source ~/.zshrc' or open a new terminal."
