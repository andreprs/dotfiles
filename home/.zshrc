# Path to your oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh
# -----------------------------------------------------------------------------
#
# Auto-update
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 20
# -----------------------------------------------------------------------------
#
# Theme
ZSH_THEME='spaceship'
# -----------------------------------------------------------------------------
#
# Case sensitive completion
CASE_SENSITIVE='true'
# -----------------------------------------------------------------------------
#
# Date format
HIST_STAMPS='dd.mm.yyyy'
# -----------------------------------------------------------------------------
#
# Plugins
plugins=(git zsh-autosuggestions zsh-highlighting)

source $ZSH/oh-my-zsh.sh
# -----------------------------------------------------------------------------
#
# Language
export LANG=pt_BR.UTF-8
# -----------------------------------------------------------------------------
#
# Apt alias
alias updg='sudo apt update && sudo apt upgrade'
alias isnt='sudo apt install'
# -----------------------------------------------------------------------------
#
# Python alias
alias py='python3.10.5'
alias pinst='pip install'
alias cvenv='python3.10.5 -m venv venv'
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
