#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Script: picom_fork.sh
# Descrição: instala o fork de JonaBurg do picom
# -----------------------------------------------------------------------------
#
# Url do github
url_picom="https://github.com/jonaburg/picom"
# -----------------------------------------------------------------------------
#
# Dependências
packages=(
    "asciidoc"
    "libxext-dev"
    "libxcb1-dev"
    "libxcb-damage0-dev"
    "libxcb-xfixes0-dev"
    "libxcb-shape0-dev"
    "libxcb-render-util0-dev"
    "libxcb-render0-dev"
    "libxcb-randr0-dev"
    "libxcb-composite0-dev"
    "libxcb-image0-dev"
    "libxcb-present-dev"
    "libxcb-xinerama0-dev"
    "libxcb-glx0-dev"
    "libpixman-1-dev"
    "libdbus-1-dev"
    "libconfig-dev"
    "libgl1-mesa-dev "
    "libpcre2-dev "
    "libevdev-dev"
    "uthash-dev"
    "libev-dev"
    "libx11-xcb-de"
)
# -----------------------------------------------------------------------------
# Instalando dependências
for package in "${packages[@]}"
do 
    sudo apt install "$package"
done
# -----------------------------------------------------------------------------
#
# Instalando
cd "$HOME" || echo "Erro."
git clone "$url_picom"
cd "$HOME"/picom || echo "Erro."
meson --buildtype=release . buildtype
ninja -C build
sudo ninja -C build install
cd "$HOME" || echo "Erro."
