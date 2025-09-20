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
yay -S --noconfirm php php-fpm php-sqlite php-gd composer docker docker-compose cursor-bin brave-bin nginx mariadb phpmyadmin redis discord less noto-fonts-cjk

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

sudo systemctl enable --now nginx
sudo systemctl enable --now php-fpm
sudo systemctl enable --now valkey
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl enable --now mariadb
sudo mariadb-secure-installation

sudo usermod -aG http gabriel

/etc/php/php-fpm.d/www.conf

user = gabriel
group = gabriel

sudo mv /usr/share/webapps/phpMyAdmin /usr/share/webapps/phpmyadmin

Access denied for user 'root'@'localhost'
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';

# Enable and configure Docker
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
newgrp docker

https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip

unzip -d JetBrainsMono ~/Download/JetBrainsMono.zip
sudo mv ~/JetBrainsMono /usr/share/fonts

fc-cache -fv

curl -sS https://starship.rs/install.sh | sh

# ~/.bashrc
eval "$(starship init bash)"

