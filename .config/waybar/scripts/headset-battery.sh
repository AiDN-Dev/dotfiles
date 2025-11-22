#!/bin/bash
battery_level=$(solaar show 2>&1 | awk '/PRO Headset/{flag=1;next}/Lightspeed Receiver/{flag=0}flag' | grep -E "Battery: [0-9]+%" | head -n 1 | sed -E 's/.*Battery: ([0-9]+)%.*/\1/')
echo "{\"text\":\"$battery_level%\", \"tooltip\": \"Headset Battery\"}"
