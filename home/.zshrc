# Path to your oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh
# -----------------------------------------------------------------------------
#
# Path
export PATH=$PATH:~/scripts
# -----------------------------------------------------------------------------
#
# Auto-update
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 20
# -----------------------------------------------------------------------------
#
# Tema
ZSH_THEME='spaceship'
# -----------------------------------------------------------------------------
#
# Case sensitive completion
CASE_SENSITIVE='true'
# -----------------------------------------------------------------------------
#
# Formato de data
HIST_STAMPS='dd.mm.yyyy'
# -----------------------------------------------------------------------------
#
# Plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
# -----------------------------------------------------------------------------
#
# Linguagem
export LANG=pt_BR.UTF-8
# -----------------------------------------------------------------------------
#
# Pacman alias
alias update='sudo pacman -Syyu'
alias install='sudo pacman -S'
alias remove='sudo pacman -R'
alias search='sudo pacman -Ss'
# -----------------------------------------------------------------------------
#
# Python alias
alias py='python'
alias pinst='pip install'
alias cvenv='python -m venv venv'
alias acvenv='source venv/bin/lib/activate'
# -----------------------------------------------------------------------------
#
# Git alias
alias ga='git add'
alias gcm='git commit'
alias gs='git status'
alias gp='git push'
alias gbm='git branch -M main'
alias gradd='git remote add origin'
alias fgp='git push -u origin main'
# -----------------------------------------------------------------------------
