#!/bin/bash

ORIGINAL_WALLPAPER="$HOME/.current.wall"
if [[ ! -f "$ORIGINAL_WALLPAPER" ]]; then
  echo "Wallpaper file not found at $ORIGINAL_WALLPAPER"
  exit 1
fi

# Make a temporary copy with a random suffix to force pywal to treat it as new
TMP_WALLPAPER="/tmp/wallpaper_$(date +%s%N).png"
cp "$ORIGINAL_WALLPAPER" "$TMP_WALLPAPER"

# Run pywal on the temp wallpaper copy, forcing no cache as well
wal -i "$TMP_WALLPAPER" -n

# Remove the temp wallpaper after use (optional)
rm "$TMP_WALLPAPER"

# Extract the color from pywal cache
COLOR_HEX=$(jq -r '.colors.color1' ~/.cache/wal/colors.json | tr -d '#')

echo "Setting keyboard lighting to color: $COLOR_HEX"

asusctl aura static -c "$COLOR_HEX"
