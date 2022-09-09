#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Descrição: launcher para o polybar
# -----------------------------------------------------------------------------
external="HDMI1"
# Terminando qualquer processo atual
killall -q polybar

# Aguardando enquanto o processo está sendo terminado
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar
polybar main -c $(dirname $0)/config.ini &

# Para setup com dois monitores
if [[ $(xrandr -q | grep "$external" connected) ]]; then
	polybar second -c $(dirname $0)/config.ini &
fi