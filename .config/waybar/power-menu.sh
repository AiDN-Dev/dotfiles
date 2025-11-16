#!/bin/bash

TMP_CONFIG_PATH="/tmp/waybar-power-menu.json"

if pgrep -f "$TMP_CONFIG_PATH" >/dev/null; then
  pkill -f "$TMP_CONFIG_PATH"
else
  cat >"$TMP_CONFIG_PATH" <<EOF
{
  "layer": "overlay",
  "exclusive": false,
  "width": 50,
  "height": 50,
  "anchor": "center",
  "modules-center":["custom/lock","custom/restart","custom/shutdown"],
  "custom/lock":{
    "format": " Lock", 
    "tooltip": false,
    "on-click": "/usr/bin/hyprlock & pkill -f ${TMP_CONFIG_PATH}"
  },
  "custom/restart":{
    "format": " restart",
    "tooltip": false,
    "on-click": "systemctl reboot"
  },
  "custom/shutdown": {
    "format": " shutdown",
    "tooltip": false,
    "on-click": "systemctl poweroff"
  }
}
EOF

  waybar -c "$TMP_CONFIG_PATH" -s ~/.config/waybar/power-menu.css &
fi

