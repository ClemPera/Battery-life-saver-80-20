#!/bin/bash

MIN=20
MAX=80
IsSend=0
STATUS=$(cat /sys/class/power_supply/BAT0/status)
BAT=$(cat /sys/class/power_supply/BAT0/capacity)
while true
do
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
