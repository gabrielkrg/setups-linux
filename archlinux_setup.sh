sudo pacman-key --init
sudo pacman-key --populate
sudo pacman -Sy archlinux-keyring
sudo pacman -Su

sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

yay -S php php-fpm php-sqlite
yay -S php-sqlite

yay -S composer
yay -S nvm

yay -S docker
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
yay -S docker-compose
