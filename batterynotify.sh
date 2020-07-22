#!/bin/bash

MIN=20
MAX=80
TIME=8000
IsSend=0

while true
do
  STATUS=$(cat /sys/class/power_supply/BAT0/status)
  BAT=$(cat /sys/class/power_supply/BAT0/capacity)
  display=":$(ls /tmp/.X11-unix/* | sed 's#/tmp/.X11-unix/X##' | head -n 1)"
  user=$(who | grep '('$display')' | awk '{print $1}' | head -n 1)
  uid=$(id -u $user)

  if [ "$BAT" -le "$MIN" ] && [ "$STATUS" == "Discharging" ] && [ "$IsSend" != "1" ]
  then
  	sudo -u $user DISPLAY=$display DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$uid/bus /usr/bin/notify-send -t $TIME --icon=battery "Battery below $MIN%. Plug it in to preserve battery lifespan!"
    IsSend=1

  elif [ "$BAT" -ge "$MAX" ] && [ "$STATUS" == 'Charging' ] || [ "$STATUS" == 'Full' ] || [ "$STATUS" == 'Unknown' ] && [ "$IsSend" != "2" ]
  then
  	sudo -u $user DISPLAY=$display DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$uid/bus /usr/bin/notify-send -t $TIME --icon=battery "Battery above $MAX%. Unplug it to preserve battery lifespan!"
    IsSend=2

  elif [ "$BAT" -lt "$MAX" ] && [ "$BAT" -gt "$MIN" ]
  then
    IsSend=0
  fi
  sleep 1m
done
