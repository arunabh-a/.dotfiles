#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt update

# Install Bitwarden
echo "Installing Bitwarden..."
wget -qO- https://vault.bitwarden.com/download/?app=desktop&platform=linux | sudo dpkg -i /dev/stdin
sudo apt -f install -y  # Fix any missing dependencies

# Install Discord
echo "Installing Discord..."
wget -qO- https://discordapp.com/api/download?platform=linux&format=deb -O discord.deb
sudo dpkg -i discord.deb
sudo apt -f install -y  # Fix any missing dependencies
rm discord.deb

# Install Telegram
echo "Installing Telegram..."
wget -qO- https://telegram.org/dl/desktop/linux | sudo dpkg -i /dev/stdin
sudo apt -f install -y  # Fix any missing dependencies

# Install Obsidian
echo "Installing Obsidian..."
wget -qO- https://github.com/obsidianmd/obsidian-releases/releases/download/v0.16.12/obsidian_0.16.12_amd64.deb -O obsidian.deb
sudo dpkg -i obsidian.deb
sudo apt -f install -y  # Fix any missing dependencies
rm obsidian.deb

# Install VSCode
echo "Installing Visual Studio Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code

# Install Ulauncher
echo "Installing Ulauncher..."
sudo add-apt-repository ppa:agornostal/ulauncher
sudo apt update
sudo apt install -y ulauncher

echo "All applications installed successfully."
