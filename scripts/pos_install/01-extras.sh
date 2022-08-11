#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Script: configs.sh
# Descrição: cria e aplica configurações do usuário e faz downloads de pacotes
#            externos;
# -----------------------------------------------------------------------------
#
# Principais caminhos
config_path="$HOME/dotfiles/config"
home_path="$HOME/dotfiles/home"
beauty_path="$HOME/dotifles/beauty"
to_install_path="$HOME/Downloads/to_install"
# -----------------------------------------------------------------------------
#
# Urls para instalações externas
URLS=(
    "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
    "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
    "https://www.python.org/ftp/python/3.10.5/Python-3.10.5.tgz"
    "https://discord.com/api/download?platform=linux&format=deb"
)
# Outras urls
spotify_url="https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg"
# -----------------------------------------------------------------------------
#
# Criando pastas de usuário e .config
mkdir -p "$HOME/.config"
xdg-user-dirs-update
mkdir "$HOME/Imagens/wallpapers"
mkdir "$to_install_path"
# -----------------------------------------------------------------------------
#
# Download e instalação de pacotes externos
for url in "${URLS[@]}"
do
    wget -P "$to_install_path" "$url"
done

# Instalando pacotes .deb
sudo dpkg -i "$to_install_path"*.deb

# Instalando versão mais recente do Python
tar -xf "$to_install_path"/Python-3.10.*.tgz
cd "$to_install_path"/Python-3.10.*/ || echo "Erro ao entrar na pasta"
./configure --enable-optimizations
make -j 4
sudo make altinstall
cd "$HOME/" || echo "Erro ao entrar na pasta"
# -----------------------------------------------------------------------------
#
# Instalando Spotify
curl -sS "$spotify_url" | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && apt-get install spotify-client -y
# -----------------------------------------------------------------------------
#
# Instalando Steam
sudo dpkg --add-architecture i386
sudo apt update && apt install steam
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
    python3.10.5 -m pip install "$module"
done
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
