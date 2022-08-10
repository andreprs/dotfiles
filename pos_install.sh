#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Script: pos_install.sh
# Descrição: script de pós-instalação do Debian (stable) com Qtile
# -----------------------------------------------------------------------------
#
# Principais caminhos
config_path="$HOME/dotfiles/config"
home_path="$HOME/dotfiles/home"
beauty_path="$HOME/dotfiles/beauty"
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
)
# -----------------------------------------------------------------------------
#
# Verificando e atualizando o sistema antes de começar a instalação
sudo apt update -y
sudo apt upgrade -y
# -----------------------------------------------------------------------------
#
# Criando pastas de usuário e .config
mkdir -p "$HOME/.config"
xdg-user-dirs-update
mkdir "$HOME/Imagens/wallpapers"
mkdir "$to_install_path"
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
#
# Instalando e tornando o zsh como shell padrão (com oh-my-zsh)
# Plugins: autosuggestions e syntax-highlighting
sudo apt install zsh -y
chsh -s /bin/zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
# Syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
# SpaceShip theme
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
# -----------------------------------------------------------------------------
#
# Alguns módulos python
python_modules=(
    "pillow"
    "requests"
    "flake8"
    "PyPDF2"
    "PyQt5"
    "mypy"
    "autopep8"
    "selenium"
    "numpy"
    "matplotlib"
)
for module in "${python_modules[@]}"
do
    python3.10 -m pip install "$module"
done
# -----------------------------------------------------------------------------
#
# Download e instalação de pacotes externos
for url in "${URLS[@]}"
do
    wget -P "$to_install_path" "$url"
done
# Instalando pacotes .deb
sudo dpkg -i "$to_install_path"*.deb

# Instalando Python 3.10
tar -xf "$to_install_path"/Python-3.10.*.tgz
cd "$to_install_path"/Python-3.10.*/ || echo "Erro inesperado"
./configure --enable-optimizations
make -j 4
sudo make altinstall
cd "$HOME" || echo "Erro inesperado"
# -----------------------------------------------------------------------------
#
# Instalando Spotify
curl -sS "$spotify_url"  | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && apt-get install spotify-client -y
# -----------------------------------------------------------------------------
#
# Instalando Steam
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install steam
# -----------------------------------------------------------------------------
#
# Copiando arquivos .config e outros
cp -R "$config_path/"* "$HOME/.config/"
cp -a "$home_path"/. "$HOME/"  # arquivos ocultos da home
sudo cp -R "$beauty_path"/fonts/* /usr/share/fonts/truetype
cp -R "$beauty_path"/wallpapers/* "$HOME/Imagens/wallpapers"
# -----------------------------------------------------------------------------
#
# Criando pasta .local
mkdir -p "$HOME/.local/opt"
mkdir -p "$HOME/.local/share"
# -----------------------------------------------------------------------------
#
# Configurações de usuário
sed -i "s/USER/$USER/g" "$HOME"/.gtkrc-2.0
