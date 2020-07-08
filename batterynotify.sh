#!/bin/bash

# TODO :
#  OK Mettre un while true avec un sleep de x min
# Mettre au startup
# OK Ne pas envoyé à l'infini
# OK exécuter tout les x MIN
# OK Mettre un autre if si c'est entre 21 et 79, reset la var
# Changer text

MIN=20
MAX=80
IsSend=0

while true
do
  STATUS=$(cat /sys/class/power_supply/BAT0/status)
  BAT=$(cat /sys/class/power_supply/BAT0/capacity)
  
  if [ "$BAT" -le "$MIN" ] && [ "$STATUS" == "Discharging" ] && [ "$IsSend" != "1" ]
  then
  	notify-send --icon=battery "Battery below $MIN%. Plug it in to preserve battery lifespan!"
    IsSend=1
  elif [ "$BAT" -ge "$MAX" ] && [ "$STATUS" == 'Charging' ] || [ "$STATUS" == 'Full' ] || [ "$STATUS" == 'Unknown' ] && [ "$IsSend" != "2" ]
  then
  	notify-send --icon=battery "Battery above $MAX%. Unplug it to preserve battery lifespan!"
    IsSend=2
  elif [ "$BAT" -lt "$MAX" ] && [ "$BAT" -gt "$MIN" ]
  then
    IsSend=0
  fi
  sleep 1m
done
