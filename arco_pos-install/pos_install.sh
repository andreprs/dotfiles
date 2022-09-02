#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Script: pos_install.sh
# Descrição: realiza download de pacotes e aplicações para uso pessoal;
#            copiar e aplica configurações de usuário;
# -----------------------------------------------------------------------------
#
# Variaveis
pacman_list="$HOME/dotfiles/arco_pos-install/pacman_list.txt"
aur_list="$HOME/dotfiles/arco_pos-install/aur_list.txt"
yay_url="https://aur.archlinux.org/yay.git"
polybar_dir="$HOME/.config/polybar"
config_path="$HOME/dotfiles/config"
home_path="$HOME/dotfiles/home"
beauty_path="$HOME/dotifles/beauty"
# =~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~
#
# Atualizando antes de instalar pacotes
echo "------ Atualizando sistema e instalando packages ------"
sleep 2

sudo pacman -Syyu --noconfirm

# Instalando pacotes com pacman
while read -r pacman_package
do
    sudo pacman -S "$pacman_package" --needed --noconfirm
done < "$pacman_list"

echo "------ Pacotes instalados ------"
sleep 2
# =~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~
#
# Instalando yay (AUR Helper) e pacotes
clear
echo "------ Instalando yay ------"
cd "$HOME"
git clone "$yay_url"
cd "$HOME"/yay
makepkg -si
cd "$HOME"

echo "------ Yay instalado com sucesso ------"
sleep 2
clear

echo "------ Instalando pacotes do AUR ------"
# Instalando pacotes do AUR
while read -r aur_package
do
    yay -S "$aur_package"
done < "$aur_list"

echo "------ Pacotes instalados ------"
sleep 2
clear
# =~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~
#
# Aplicando configurações

# Criando pastas .local
mkdir -p "$HOME"/.local/share
mkdir -p "$HOME"/.local/share/fonts

# Copiando arquivos
cp -R "$config_path"/* "$HOME"/.config/
cp -R "$beauty_path"/fonts/* "$HOME"/.local/share/fonts/
cp -R "$beauty_path"/wallpapers/* "$HOME"/Imagens/wallpapers/
cp -a "$home_path"/. "$HOME"/

# Dando permissões aos scripts necessários
chmod +x "$HOME"/.xinitrc
chmod +x "$polybar_dir"/launch.sh
chmod +x "$polybar_dir"/forest/scripts/rofi/*

# Gtk-2.0
sed -i "s/USER/$USER/g" "$HOME"/.gtkrc-2.0

# -----------------------------------------------------------------------------