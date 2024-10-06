#!/bin/bash

# Define the path to your dotfiles repository
DOTFILES_DIR="$HOME/.dotfiles/"

# Create symbolic links for directories
ln -sf "$DOTFILES_DIR/zed" "$HOME/.config/zed"
ln -sf "$DOTFILES_DIR/ulauncher" "$HOME/.config/ulauncher"
ln -sf "$DOTFILES_DIR/.icons" "$HOME/.icons"
ln -sf "$DOTFILES_DIR/.themes" "$HOME/.themes"
ln -sf "$DOTFILES_DIR/.vscode" "$HOME/.vscode"
ln -sf "$DOTFILES_DIR/icons" "$HOME/.local/share/icons"
# ln -sf "$DOTFILES_DIR/Hidamari" "$HOME/Videos/Hidamari"

# Create symbolic links for files
ln -sf "$DOTFILES_DIR/.zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
ln -sf "$DOTFILES_DIR/.bash_profile" "$HOME/.bash_profile"
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
ln -sf "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"



echo "Symbolic linking Completed."
