#!/bin/bash

if command -v jq &>/dev/null; then

  OUTPUT=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name')
else
  OUTPUT=$(hyprctl monitors | awk '/focused: yes/ {print monitor} /^Monitor/ {monitor=$2}')
fi

if [ -z "$OUTPUT" ]; then
  echo "Could not determine the focused monitor" >&2
  exit 1
fi

TMP_CONFIG_PATH="/tmp/waybar-tray-%output%.json"

TRAY_KEYWORD="${TMP_CONFIG_PATH}"

if pgrep -f "$TRAY_KEYWORD" >/dev/null; then
  pkill -f "$TRAY_KEYWORD"
  rm -f "$TMP_CONFIG_PATH"
else
  pkill -f "waybar-tray-"
  rm -f /tmp/waybar-tray-%output%.json

  cat >"$TMP_CONFIG_PATH" <<EOF
  {
    "output": "$OUTPUT",
    "layer": "overlay",
    "exclusive": false,
    "position": "top",
    "modules-right": [ "tray" ],
    "tray": {
      "icon-size": 15,
      "spacing": 10
    }
  }
EOF

  waybar -c "$TMP_CONFIG_PATH" -s ~/.config/waybar/tray-style.css &

fi
