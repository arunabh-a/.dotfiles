#/bin/bash

# Define the path to your dotfiles repository
DOTFILES_DIR="$HOME/.dotfiles/"

# Copy directories
# sudo cp -r "$DOTFILES_DIR/zed" "$HOME/.config/zed"
# sudo cp -r "$DOTFILES_DIR/ulauncher" "$HOME/.config/ulauncher"
sudo cp -r "$DOTFILES_DIR/.icons" "$HOME/.icons"
sudo cp -r "$DOTFILES_DIR/.themes" "$HOME/.themes"
sudo cp -r "$DOTFILES_DIR/.vscode" "$HOME/.vscode"
sudo cp -r "$DOTFILES_DIR/icons" "$HOME/.local/share/icons"
sudo cp -r "$DOTFILES_DIR/nvim" "$HOME/.config/nvim/"
# sudo cp -r "$DOTFILES_DIR/Hidamari" "$HOME/Videos/Hidamari"

# Copy files
sudo cp "$DOTFILES_DIR/.zshenv" "$HOME/.zshenv"
sudo cp "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
sudo cp "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
sudo cp "$DOTFILES_DIR/.bash_profile" "$HOME/.bash_profile"
sudo cp "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
sudo cp "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
sudo cp "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"



echo "Dotfiles Imported.."
