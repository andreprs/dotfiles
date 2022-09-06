#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Script: pos_install.sh
# Descrição: realiza download de pacotes e aplicações para uso pessoal;
#            copia e aplica configurações de usuário;
# -----------------------------------------------------------------------------
#
# Variaveis
pacman_list="$HOME/dotfiles/arco_pos-install/pacman_list.txt"
aur_list="$HOME/dotfiles/arco_pos-install/aur_list.txt"
polybar_dir="$HOME"/.config/polybar
config_path="$HOME"/dotfiles/config
home_path="$HOME"/dotfiles/home
beauty_path="$HOME"/dotifles/beauty
bin_path="$HOME"/dotfiles/bin
oh_my_zsh="$HOME"/.oh_my_zsh/custom

# Links
autosuggestions="https://github.com/zsh-users/zsh-syntax-highlighting.git"
syntax_high="https://github.com/zsh-users/zsh-autosuggestions.git"
spaceship="https://github.com/denysdovhan/spaceship-prompt.git"
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
# Instalando pacotes do AUR
# Por padrão, o yay (AUR helper) já vem instalado no ArcoLinux
clear
echo "------ Instalando pacotes do AUR ------"
# Instalando pacotes do AUR
while read -r aur_package
do
    yay -S "$aur_package"
done < "$aur_list"

echo "------ Pacotes AUR instalados ------"
sleep 2
clear
# =~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~
#
# Instalando Oh-my-ZSH
curl -L http://install.ohmyz.sh | sh
echo "------ Oh-my-ZSH instalado com sucesso ------"
sleep 2
clear
# =~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~
#
# Aplicando configurações

# Removendo o arquivo .zshrc padrão gerado pelo Oh-my-ZSH
rm "$HOME"/.zshrc

# Tornando zsh como shell padrão
chsh -s /bin/zsh

# Instalando plugins e temas ao Oh-my-ZSH
git clone "$autosuggestions" "$oh_my_zsh"/plugins/zsh-autosuggestions
git clone "$syntax_high" "$oh_my_zsh"/plugins/zsh-syntax-highlighting
git clone "$spaceship" "$oh_my_zsh"/themes/spaceship-prompt
ln -s "$oh_my_zsh/themes/spaceship-prompt/spaceship.zsh-theme" "$oh_my_zsh/themes/spaceship.zsh-theme"

# Criando pastas .local
mkdir -p "$HOME"/.local/share
mkdir -p "$HOME"/.local/share/fonts
mkdir -p "$HOME"/.local/bin

# Copiando arquivos
echo "------ Copiando arquivos ------"
cp -R "$config_path"/* "$HOME"/.config/
cp -R "$beauty_path"/fonts/* "$HOME"/.local/share/fonts/
cp -R "$beauty_path"/wallpapers/* "$HOME"/Imagens/wallpapers/
cp -R "$bin_path"/* "$HOME"/.local/bin/
cp -a "$home_path"/. "$HOME"/
echo "------ Arquivos de configuração e home copiados ------"
sleep 2
clear

# Dando permissões aos arquivos necessários
echo "------ Dando as permissões necessárias ------"
chmod -R +x "$HOME"/.xinitrc
chmod -R +x "$HOME"/.config/bspwm/bspwmrc
chmod -R +x "$HOME"/.config/sxhkd/sxhkdrc
chmod -R +x "$HOME"/scripts/*
chmod -R +x "$polybar_dir"/launch.sh
chmod -R +x "$polybar_dir"/forest/scripts/*.sh
chmod -R +x "$polybar_dir"/forest/scripts/checkupdates
chmod -R +x "$HOME"/.config/ranger/scope.sh
echo "------ Permissões realizadas ------"
sleep 2
clear

# Configurações de sistema
echo "------ Configurações de sistema ------"
modprobe stusb
sudo systemctl enable ly.service
sudo systemctl enable NetworkManager.service
sudo systemctl enable bluetooth.service
sleep 2
clear
# -----------------------------------------------------------------------------
#
# Reiniciar o sistema 
echo -n "Reiniciar o sistema? [S/n] "
select escolha in Sim Nao
do
    case $escolha in
        "Sim")
            clear
            echo "--- Reiniciando o sistema ---"
            sleep 2
            reboot;;
        "Nao")
            clear
            echo "--- Voltando ao terminal ---"
            sleep 2
            break;;
        *)
            clear
            echo "Sem resposta... Voltando ao terminal"
            sleep 2
            break;;
    esac
done