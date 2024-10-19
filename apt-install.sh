#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt update

sudo apt-get install wget gpg flatpak gnome-software-plugin-flatpak

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Install Bitwarden
echo "Installing Bitwarden..."
flatpak install flathub com.bitwarden.desktop

# Install Discord
echo "Installing Discord..."\
flatpak install flathub com.discordapp.Discord

# Install Telegram
echo "Installing Telegram..."
flatpak install flathub org.telegram.desktop

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

