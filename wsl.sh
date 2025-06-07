#!/bin/bash

# WSL Setup Script

echo "Starting WSL setup..."

# Update package list
sudo apt update

# Install git
echo "Installing git..."
sudo apt install -y git

# Install GitHub CLI
echo "Installing GitHub CLI..."
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
        && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
        && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y

# Authenticate with GitHub
echo "Authenticating with GitHub..."
gh auth login

# Run zsh setup script
echo "Running zsh setup..."
if [ -f "./zsh-setup.sh" ]; then
    chmod +x ./zsh-setup.sh
    ./zsh-setup.sh
else
    echo "Warning: zsh-setup.sh not found in current directory"
fi

# Install curl
echo "Installing curl..."
sudo apt install -y curl

# Install wget
echo "Installing wget..."
sudo apt install -y wget

# Install neovim
echo "Installing Neovim..."
sudo apt install -y neovim

# Installing NVM
echo "Installing NVM (Node Version Manager)..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
echo "NVM installed. Please restart your terminal or run the following command to load NVM:"

# Installing Node
echo "Installing Node.js using NVM..."
nvm install node # "node" is an alias for the latest version

echo "WSL setup completed!"