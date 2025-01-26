#!/bin/bash
set -e

# Update keyring and packages
# pacman-key --init
# pacman-key --populate
# pacman -Sy archlinux-keyring
# pacman -Su --noconfirm

# Install yay
pacman -S --needed --noconfirm git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..

# Install packages
yay -S --noconfirm php php-fpm php-sqlite composer nvm docker docker-compose

# Enable and configure Docker
systemctl enable --now docker
usermod -aG docker $USER
newgrp docker
