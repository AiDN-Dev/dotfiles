#!/bin/bash

#--- CONFIG
#Fill these values in with monitor details
MONITOR_NAME="HDMI-A-1"
MONITOR_CONFIG="1920x1080@60"
UNLOCKED_X=1920
SCALE="1.0"
MONITOR_INDEX=0
#--- END CONFIG

#The locked X position
LOCKED_X=9999

#get the current x position of the monitor using its index
current_x=$(hyprctl -j monitors | jq --argjson index "$MONITOR_INDEX" '.[$index].x')

#Check if the monitior is currently in the unlocked position
if [ "$current_x" -eq "$UNLOCKED_X" ]; then
  #if it is move if to the locked position
  echo "Locking monitor ${MONITOR_NAME}."
  hyprctl keyword monitor "${MONITOR_NAME},${MONITOR_CONFIG},${LOCKED_X}x0,${SCALE}"
else
  #If its not move it to the unlocked position
  echo "Unlocking monitor ${MONITOR_NAME}."
  hyprctl keyword monitor "${MONITOR_NAME},${MONITOR_CONFIG},${UNLOCKED_X}x0,${SCALE}"
fi

#Kill waybar and re-launch it else position gets scuffed.
killall -q waybar
sleep 0.1
waybar &
