#!/bin/bash
battery_level=$(solaar show 2>&1 | awk '/PRO Headset/{flag=1;next}/Lightspeed Receiver/{flag=0}flag' | grep -E "Battery: [0-9]+%" | head -n 1 | sed -E 's/.*Battery: ([0-9]+)%.*/\1/')

if [ -n "$battery_level" ]; then
  color=""
  if [ "$battery_level" -le 15 ]; then
    color="#BF616A"
  elif [ "$battery_level" -le 30 ]; then
    color="#EBCB8B"
  else
    color="#A3BE8C"
  fi

  text="<span color='${color}'>󰋎 ${battery_level}%</span>"
  echo "{\"text\": \"${text}\", \"tooltip\": \"Headset Battery: ${battery_level}%\"}"
else
  echo "{\"text\": \"\", \"tooltip\": \"Headset Disconnected\"}"
fi
