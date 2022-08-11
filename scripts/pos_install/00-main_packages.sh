#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Script: main_packages.sh
# Descrição: downloads de pacotes essenciais para o meu uso;
# -----------------------------------------------------------------------------
#
# Pacotes que serão instalados
packages=(
    "build-essential"
    "curl"
    "lynx"
    "wget"
    "zlib1g-dev"
    "libncurses5-dev"
    "libgdbm-dev"
    "libnss3-dev"
    "libssl-dev"
    "libreadline-dev"
    "libffi-dev"
    "libsqlite3-dev"
    "libbz2-dev"
    "gcc"
    "make"
    "dkms"
    "xorg"
    "xutils"
    "mesa-utils"
    "firmware-linux"
    "firmware-linux-nonfree"
    "pulseaudio"
    "pavucontrol"
    "alsa-firmware-loaders"
    "alsa-utils"
    "intel-microcode"
    "intel-microcode"
    "firmware-atheros"
    "firmware-realtek"
    "firmware-iwlwifi"
    "ffmpeg"
    "samba"
    "network-manager-gnome"
    "xfce4-power-manager"
    "aspell"
    "aspell-pt-br"
    "neofetch"
    "htop"
    "inxi"
    "wmctrl"
    "xdotool"
    "xinput"
    "policykit-1-gnome"
    "fzf"
    "zenity"
    "yad"
    "blueman"
    "dunst"
    "gparted"
    "youtube-dl"
    "ttf-mscorefonts-installer"
    "numlockx"
    "p7zip-full"
    "rar"
    "unrar"
    "arandr"
    "papirus-icon-theme"
    "arc-theme"
    "kitty"
    "picom"
    "rofi"
    "ranger"
    "nautilus"
    "zathura"
    "vim"
    "zsh"
)
# -----------------------------------------------------------------------------
#
# Verificando e atualizando o sistema antes de começar a instalação
sudo apt update -y
sudo apt upgrade -y
# -----------------------------------------------------------------------------
#
# Instalando pacotes
for package in "${packages[@]}" 
do
    sudo apt install "$package" -y
done
# -----------------------------------------------------------------------------
#
# Dependências do Qtile e instalação
qtile_dependences=(
    "xserver-xorg"
    "xinit"
    "libpangocairo-1.0-0"
    "python3-pip"
    "python3-xcffib"
    "python3-cairocffi"
)

for dependence in "${qtile_dependences[@]}"
do
    sudo apt install "$dependence" -y
done

pip install qtile  # No debian a instalação do qtile é feita pelo pip
# -----------------------------------------------------------------------------
