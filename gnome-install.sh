#!/bin/bash

# Define the path to your dotfiles repository
DOTFILES_DIR="$HOME/path/to/your/dotfiles/repo"

# List of GNOME extensions to install
GNOME_EXTENSIONS=(
    "user-theme@gnome-shell-extensions.gcampax.github.com"
    "Vitals@CoreCoding.com"
    "ding@rastersoft.com"
    "appindicatorsupport@rgcjonas.gmail.com"
    "gnome-ui-tune@itstime.tech"
    "drive-menu@gnome-shell-extensions.gcampax.github.com"
    "blur-my-shell@aunetx"
    "just-perfection-desktop@just-perfection"
    "quick-settings-tweaks@qwreey"
    "rounded-window-corners@fxgn"
    "vertical-workspaces@G-dH.github.com"
    "dash-to-dock@micxgx.gmail.com"
    "apps-menu@gnome-shell-extensions.gcampax.github.com"
    "background-logo@fedorahosted.org"
    "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
    "places-menu@gnome-shell-extensions.gcampax.github.com"
    "window-list@gnome-shell-extensions.gcampax.github.com"
)

# Function to install packages
install_packages() {
    echo "Updating package list..."
    sudo apt update

    echo "Installing required packages..."
    sudo apt install -y gnome-shell-extensions gnome-tweaks gnome-shell-extension-prefs gnome-shell-extension-manager
}



# Function to install GNOME extensions
install_gnome_extensions() {
    echo "Installing GNOME extensions..."

    for EXT_ID in "${GNOME_EXTENSIONS[@]}"; do
        if ! gnome-extensions list | grep -q "$EXT_ID"; then
            echo "Installing extension: $EXT_ID"
            gnome-extensions install "$EXT_ID"
        else
            echo "Extension $EXT_ID already installed."
        fi
    done
}

# Function to configure GNOME settings
configure_gnome_settings() {
    echo "Configuring GNOME settings..."

    # Set icon theme
    gsettings set org.gnome.desktop.interface icon-theme "WhiteSur-dark"

    # Set GNOME Shell theme
    gsettings set org.gnome.shell.extensions.user-theme name "Tokyonight-Dark-BL-GS"

    # Set GTK theme
    gsettings set org.gnome.desktop.interface gtk-theme "Tokyonight-Dark"

    # Set button layout
    gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"

    # Center new windows
    gsettings set org.gnome.mutter center-new-windows true
}
# Execute functions
install_packages
install_gnome_extensions
configure_gnome_settings

echo "GNOME setup completed successfully."
