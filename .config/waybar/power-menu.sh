#!/bin/bash

POWER_MENU_CONFIG_PATH="/tmp/waybar-power-menu.json"

# function to kill any related waybar processe
kill_waybar_powermenu() {
  #kill the dimmer and power menu instances
  pkill -f "$POWER_MENU_CONFIG_PATH"
}

# if any related power menu is running kill them
if pgrep -f "$POWER_MENU_CONFIG_PATH" >/dev/null; then
  kill_waybar_powermenu
  exit 0
fi
#Create the config for the power menu
cat >"$POWER_MENU_CONFIG_PATH" <<EOF
  {
    "layer": "overlay", 
    "exclusive" : false, 
    "width": 50, 
    "height": 50, 
    "anchor": "center",
    "modules-center": ["custom/lock", "custom/restart", "custom/shutdown"],
    "custom/lock": {
      "format": " Lock", 
      "tooltip": false, 
      "on-click": " /usr/bin/hyprlock && pkill -f $POWER_MENU_CONFIG_PATH "
    },
    "custom/restart": {
      "format": " Restart",
      "tooltip": false,
      "on-click": "systemctl reboot"
    },
    "custom/shutdown": {
      "format": " Shutdown",
      "tooltip": false,
      "on-click": "systemctl poweroff"
    }
  }
}
EOF

#Add the kill fucntion to the ecnvironment so it can be called from waybars on on-click
export -f kill_waybar_powermenu

waybar -c "$POWER_MENU_CONFIG_PATH" -s ~/.config/waybar/power-menu.css
