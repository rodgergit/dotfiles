#!/bin/bash

# Define the path to your dotfiles repo and the target location
DOTFILES_DIR="/Users/rodgerchen/Developer/dotfiles"
TARGET="$HOME/.zshrc"

# Source file in the dotfiles repo
SOURCE="$DOTFILES_DIR/.zshrc"

# Check if the target already exists and remove it if it's a symlink
if [ -L "$TARGET" ]; then
  echo "Removing existing symlink at $TARGET"
  unlink "$TARGET"
elif [ -e "$TARGET" ]; then
  echo "Warning: $TARGET already exists but is not a symlink. Skipping..."
  exit 1
fi

# Create the symlink
ln -s "$SOURCE" "$TARGET"
echo "Symlink created: $TARGET -> $SOURCE"