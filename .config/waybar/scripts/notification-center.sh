#!/bin/bash

#get the notifcation history from dunst
notifcations=$(dunstctl history | jq -r '.data[0][] | 
  "<b>" + (.appname.data | sub ("&"; "&amp;")) + ": " + (.summary.data | 
  sub("&"; "&amp;")) + "</b>\n" + "<small>" + (.body.data | sub("&"; "&amp;")) + "</small>"')

#use wofi to display the formatted notifcations
#--dmenu: reads items from stdin.
#--location top_left: positions the window
#--allow-markup: renders the pango markup
#--width/--height: sets the size of the wofi window
echo -e "$notifcations" | wofi --dmenu --location top_right --yoffset=10 --xoffset=-100 --width=400 --height=500 --allow-markup

#the script will ext after you select an item of close wofi
#will change this to allow deleting.
