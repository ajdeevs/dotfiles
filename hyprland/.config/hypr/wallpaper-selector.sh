#!/bin/bash

WALLPAPER_DIR="$HOME/Videos/live-Wallpaper"
MONITOR="eDP-1"
CONFIG_FILE="$HOME/.config/hypr/last-wallpaper.txt"
HYP_PANEL_CONFIG="$HOME/.config/hyprpanel/config"

# Choose wallpaper
SELECTED=$(ls "$WALLPAPER_DIR" | rofi -dmenu -p "Choose wallpaper")
[ -z "$SELECTED" ] && exit
echo "$SELECTED" >"$CONFIG_FILE"

# Extract a unique frame and generate Pywal colors
STAMP=$(date +%s)
FRAME="/tmp/wal_frame_$STAMP.png"
ffmpeg -y -i "$WALLPAPER_DIR/$SELECTED" -ss 00:00:02 -vframes 1 "$FRAME"
wal -i "$FRAME"

cp "$FRAME" ~/.config/wal_frame.png
# Clean up older frames
find /tmp -maxdepth 1 -name 'wal_frame_*.png' -mmin +5 -delete

# Apply to Hyprland borders
source "$HOME/.cache/wal/colors.sh"
if [[ -n "$color0" && -n "$color4" ]]; then
  hyprctl keyword general:col.active_border "rgba(${color4:1}ff)"
  hyprctl keyword general:col.inactive_border "rgba(${color0:1}ff)"
fi

# Apply to Hyprpanel
if [ -f "$HYP_PANEL_CONFIG" ]; then
  sed -i "s/^background = .*/background = $color0/" "$HYP_PANEL_CONFIG"
  sed -i "s/^foreground = .*/foreground = $color7/" "$HYP_PANEL_CONFIG"
  pkill -x hyprpanel && hyprpanel &
fi

# Kill old wallpaper and start new one
pkill -x mpvpaper
mpvpaper -o "loop-file=inf no-audio no-osc fullscreen keepaspect=no" "$MONITOR" "$WALLPAPER_DIR/$SELECTED"
