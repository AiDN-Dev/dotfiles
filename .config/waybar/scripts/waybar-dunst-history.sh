#!/bin/bash
count=$(dunstctl count waiting)

if [ "$count" -gt 0 ]; then
  echo '{"text": " Bell", "class": "has-notifications", "tooltip": "You have '"$count"' pending notifications"}'
else
  echo '{"text": " Bell", "class": "no-notifications", "tooltip": "No pending notifications"}'
fi
