#!/bin/bash
set -e

# Update keyring and packages
sudo pacman-key --init
sudo pacman-key --populate
sudo pacman -Sy archlinux-keyring
sudo pacman -Su --noconfirm

# Install yay
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s /usr/share/nvm/nvm.sh ] && \. /usr/share/nvm/nvm.sh
[ -s /usr/share/nvm/bash_completion ] && \. /usr/share/nvm/bash_completion


# Install packages
yay -S --noconfirm php php-fpm php-sqlite composer nvm docker docker-compose

# Enable and configure Docker
systemctl enable --now docker
usermod -aG docker $USER
newgrp docker
