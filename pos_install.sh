#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Script: pos_install.sh
# Descrição: script de pós-instalação do Debian (stable) com Qtile
# -----------------------------------------------------------------------------
# Pastas de usuário
directories=(
    "imagens"
    "documentos"
    "videos"
    "desktop"
    "downloads"
    "musica"
)
# -----------------------------------------------------------------------------
# Urls para instalações externas
URLS=(
    "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
    "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
    "https://www.python.org/ftp/python/3.10.5/Python-3.10.5.tgz"
)
# -----------------------------------------------------------------------------
# Pacotes que serão instalados
packages=(
    "build-essential"
    "curl"
    "lynx"
    "wget"
    "zlib1g-dev"
    "libncurses5-dev"
    "libgdbm-dev"
    "libns"
    "s3-dev"
    "libssl-dev"
    "libreadline-dev"
    "libffi-dev"
    "libsqlite3-dev"
    "libbz2-dev"
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
    "ffmepeg"
    "samba"
    "wicd-curses"
    "network-manager-gnome"
    "xfce4-power-manager"
    "aspell"
    "alpell-pt-br"
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
    "gparted"
    "youtube-dl"
    "ttf-mscorefonts-installer"
    "numlockx"
    "p7zip-full"
    "rar"
    "unrar"
)
# -----------------------------------------------------------------------------
# Verificando e atualizando o sistema antes de começar a instalação
sudo apt update
sudo apt upgrade -y
# -----------------------------------------------------------------------------
# Instalando pacotes
for package in "${packages[@]}" 
do
    sudo apt install "$package" -y
done
# -----------------------------------------------------------------------------
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
# Criando pastas de usuário
for directorie in "${directories[@]}"
do
    mkdir "$HOME/$directorie"
done
# -----------------------------------------------------------------------------
# Download de pacotes externos
for url in "${URLS[@]}"
do
    wget -P "$HOME/downloads" "$url"
done
# -----------------------------------------------------------------------------
