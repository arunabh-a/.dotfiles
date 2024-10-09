#!/bin/bash

# List of GNOME extensions to install
# GNOME_EXTENSIONS=(
#     "user-theme@gnome-shell-extensions.gcampax.github.com"
#     "Vitals@CoreCoding.com"
#     "ding@rastersoft.com"
#     "appindicatorsupport@rgcjonas.gmail.com"
#     "gnome-ui-tune@itstime.tech"
#     "drive-menu@gnome-shell-extensions.gcampax.github.com"
#     "blur-my-shell@aunetx"
#     "just-perfection-desktop@just-perfection"
#     "quick-settings-tweaks@qwreey"
#     "rounded-window-corners@fxgn"
#     "vertical-workspaces@G-dH.github.com"
#     "dash-to-dock@micxgx.gmail.com"
#     "apps-menu@gnome-shell-extensions.gcampax.github.com"
#     "background-logo@fedorahosted.org"
#     "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
#     "places-menu@gnome-shell-extensions.gcampax.github.com"
#     "window-list@gnome-shell-extensions.gcampax.github.com"
# )

# Additional extensions from URLs
GNOME_EXTENSIONS=(
    "https://extensions.gnome.org/extension/4245/gesture-improvements/"
    "https://extensions.gnome.org/extension/19/user-themes/"
    "https://extensions.gnome.org/extension/3843/just-perfection/"
    "https://extensions.gnome.org/extension/5446/quick-settings-tweaker/"
    "https://extensions.gnome.org/extension/7048/rounded-window-corners-reborn/"
    "https://extensions.gnome.org/extension/5177/vertical-workspaces/"
    "https://extensions.gnome.org/extension/3740/compiz-alike-magic-lamp-effect/"

)

# Function to install packages
install_packages() {
    echo "Updating package list..."
    sudo apt update

    echo "Installing required packages..."
    sudo apt install -y gnome-shell-extensions gnome-tweaks gnome-shell-extension-prefs gnome-shell-extension-manager jq wget 
}

# Function to install GNOME extensions
install_gnome_extensions() {
    echo "Installing GNOME extensions..."

    # Install additional extensions from URLs
    for URL in "${GNOME_EXTENSIONS[@]}"; do
        EXTENSION_ID=$(curl -s "$URL" | grep -oP 'data-uuid="\K[^"]+')
        VERSION_TAG=$(curl -Lfs "https://extensions.gnome.org/extension-query/?search=$EXTENSION_ID" | jq '.extensions[0] | .shell_version_map | map(.pk) | max')
        
        wget -O "${EXTENSION_ID}.zip" "https://extensions.gnome.org/download-extension/${EXTENSION_ID}.shell-extension.zip?version_tag=${VERSION_TAG}"
        gnome-extensions install --force "${EXTENSION_ID}.zip"
        
        if ! gnome-extensions list | grep --quiet "${EXTENSION_ID}"; then
            busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s "${EXTENSION_ID}"
        fi
        
        gnome-extensions enable "${EXTENSION_ID}"
        rm "${EXTENSION_ID}.zip"
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
# configure_gnome_settings

echo "GNOME setup completed successfully."
