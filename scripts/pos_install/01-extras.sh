#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Script: extras.sh
# Descrição: realiza download de extras que considero essencial para o meu uso
# -----------------------------------------------------------------------------
#
# Criando pastas de usuário e .config
mkdir -p "$HOME/.config"
xdg-user-dirs-update
# -----------------------------------------------------------------------------
#
# Instalando yay (AUR Helper)
yay_url="https://aur.archlinux.org/yay.git"

cd "$HOME" || echo "Erro."
git clone "$yay_url"

cd "$HOME"/yay/ || Echo "Erro."
makepkg -si  # compilar e instalar
# -----------------------------------------------------------------------------
#
# Pacotes do AUR
AUR_pkgs=(
    "atom"
    "spotify"
    "google-chrome"
    "ttf-ms-fonts"
    "mouse_m908"
    "picom-pijulius-git"
    "nerd-fonts-fira-code"
    "nerd-fonts-jetbrains-mono"
    "nerd-fonts-ubuntu-mono"
    "ttf-icomoon-feather"
    "catppuccin-gtk-theme"
    "pfetch"
)

for pkg in "${AUR_pkgs[@]}"
do
    yay -S "$pkg"
done
# -----------------------------------------------------------------------------
#
# Alguns módulos Python
python_modules=(
    "pillow"
    "requests"
    "flake8"
    "PyPDF2"
    "mypy"
    "autopep8"
    "selenium"
    "numpy"
    "matplotlib"
)

for module in "${python_modules[@]}"
do
    python3 -m pip install "$module"
done
# -----------------------------------------------------------------------------
