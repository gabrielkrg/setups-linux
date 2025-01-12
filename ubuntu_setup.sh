#!/bin/bash

# Update package list
sudo apt update

# Install prerequisites for PHP and add PHP repository
sudo apt -y install software-properties-common
sudo add-apt-repository -y ppa:ondrej/php

# Install PHP 8.3 and PHP-FPM 8.3
sudo apt -y install php8.3 php8.3-fpm

# Install PHP extensions for PHP 8.3
sudo apt -y install php8.3-pdo php8.3-mysql php8.3-mbstring php8.3-exif php8.3-gd

# Install Composer
sudo apt -y install curl php-cli unzip
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
source ~/.bashrc

# Install Node.js using NVM
nvm install node
