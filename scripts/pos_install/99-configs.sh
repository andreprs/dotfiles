#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Script: configs.sh
# Descrição: copia e aplica configurações de usuário;
# -----------------------------------------------------------------------------
#
# Principais caminhos
config_path="$HOME/dotfiles/config"
home_path="$HOME/dotfiles/home"
beauty_path="$HOME/dotifles/beauty"
# -----------------------------------------------------------------------------
#
# Criando pastas .local
mkdir -p "$HOME/.local/opt"
mkdir -p "$HOME/.local/share"
# -----------------------------------------------------------------------------
#
# Copiando arquivos .config e outros
cp -R "$config_path/"* "$HOME/.config/"
cp -a "$home_path"/. "$HOME/" # arquivos ocultos da home
sudo cp -R "beauty_path"/fonts/* /usr/share/fonts/truetype/
cp -R "$beauty_path"/wallpapers/* "$HOME/Imagens/wallpapers "
# -----------------------------------------------------------------------------
#
# Configurações de usuário
sed -i "s/USER/$USER/g" "$HOME"/.gtkrc-2.0
