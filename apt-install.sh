#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt update

sudo apt-get install wget gpg

# Installing Brave Browser
echo "Installing Brave Browser"
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list


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
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code

# Installing Notion Enhanced
echo "Installing Notion for Linux...."
echo "deb [trusted=yes] https://apt.fury.io/notion-repackaged/ /" | sudo tee /etc/apt/sources.list.d/notion-repackaged.list
sudo apt update
sudo apt install notion-app

# Installing Spotify
echo "Installing Spotify..."
curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update
sudo apt-get install spotify-client 

# Install Ulauncher
echo "Installing Ulauncher..."
sudo add-apt-repository ppa:agornostal/ulauncher
sudo apt update
sudo apt install -y ulauncher

echo "All applications installed successfully."

