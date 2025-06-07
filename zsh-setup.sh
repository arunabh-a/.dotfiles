echo "Installing zsh setup..."
if command -v dnf &> /dev/null; then
    sudo dnf install zsh
elif command -v apt &> /dev/null; then
    sudo apt update && sudo apt install zsh
elif command -v pacman &> /dev/null; then
    sudo pacman -S zsh
elif command -v zypper &> /dev/null; then
    sudo zypper install zsh
else
    echo "Package manager not supported. Please install zsh manually."
    exit 1
fi

echo "Importing Oh-My-zsh config..."
sudo cp -r .oh-my-zsh $HOME/

echo "Importing Powerlevel 10k Config..."
sudo cp .p10k

