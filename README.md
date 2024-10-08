# dotfiles

## Installation

```bash
git clone
cd .dotfiles
./dotfiles.sh
```

### Being Inside .dotfiles folder

```bash
sudo cp -r gnome-extension-config/local/*  ~/.local/share/gnome-shell/extensions/
sudo cp -r gnome-extension-config/system/*  ~/.local/share/gnome-shell/extensions/

dconf load /org/gnome/shell/extensions/ < gnome-extensions-settings.conf

```




# (END)
