#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Script: pos_install.sh
# Descrição: script de pós-instalação do Debian (stable) com Qtile
# -----------------------------------------------------------------------------

packages=(
    'build-essential'
    'curl'
    'lynx'
    'xorg'
    'xserver-xorg'
    'xutils'
    'xinit'
    'mesa-utils'
    'firmware-linux'
    'firmware-linux-nonfree'
    'pulseaudio'
    'pavucontrol'
    'alsa-firmware-loaders'
    'alsa-utils'
    'intel-microcode'
    'intel-microcode'
    'firmware-atheros'
    'firmware-realtek'
    'firmware-iwlwifi'
    'ffmepeg'
    'samba'
    'wicd-curses'
    'network-manager-gnome'
    'xfce4-power-manager'
    'aspell'
    'alpell-pt-br'
    'neofetch'
    'htop'
    'inxi'
    'wmctrl'
    'xdotool'
    'xinput'
    'policykit-1-gnome'
    'fzf'
    'zenity'
    'yad'
    'blueman'
    'gparted'
    'youtube-dl'
    'ttf-mscorefonts-installer'
    'numlockx'
    'p7zip-full'
    'rar'
    'unrar'
)

for package in "${packages[@]}" 
do
    echo "$package"
done
