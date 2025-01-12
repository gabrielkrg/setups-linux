#!/bin/bash

# Default values
PHP_VERSION="8.3"
DOCKER_INSTALL=true

# Update package list
sudo apt update

# Install prerequisites for PHP and add PHP repository
sudo apt -y install software-properties-common
sudo add-apt-repository -y ppa:ondrej/php

# Install PHP and PHP-FPM using the PHP_VERSION variable
sudo apt -y install php$PHP_VERSION php$PHP_VERSION-fpm

# Install PHP extensions for the specified PHP version
sudo apt -y install php$PHP_VERSION-pdo php$PHP_VERSION-mysql php$PHP_VERSION-mbstring php$PHP_VERSION-exif php$PHP_VERSION-gd php$PHP_VERSION-curl php$PHP_VERSION-xml

# Install Composer
sudo apt -y install curl php-cli unzip
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm install stable

# Install Docker and Docker Compose if --docker=true
if [ "$DOCKER_INSTALL" = true ]; then
    echo "Installing Docker and Docker Compose..."

    # Remove conflicting packages
    for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
        sudo apt-get remove -y $pkg
    done

    # Install Docker prerequisites
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add Docker repository to Apt sources
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update

    # Install Docker and Docker Compose
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Start Docker service
    sudo systemctl start docker
    sudo systemctl enable docker

    # Verify Docker and Docker Compose installation
    docker --version
    docker-compose --version

    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker
fi

# Notify user of completion
echo "Installation complete: PHP $PHP_VERSION, Composer, NVM, and Node.js installed successfully."
if [ "$DOCKER_INSTALL" = true ]; then
    echo "Docker and Docker Compose have been installed."
fi

source ~/.bashrc
