#!/bin/bash
set -e

# Update keyring and packages
sudo pacman-key --init
sudo pacman-key --populate
sudo pacman -Sy archlinux-keyring
sudo pacman -Su --noconfirm

# Install yay
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

# Install packages
yay -S --noconfirm php php-fpm php-sqlite php-gd composer docker docker-compose cursor-bin brave-bin nginx mariadb discord

sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

# Enable and configure Docker
systemctl enable --now docker
usermod -aG docker $USER
newgrp docker
