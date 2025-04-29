#!/bin/bash

WALLPAPER_DIR="$HOME/Videos/live-Wallpaper"
MONITOR="eDP-1"
CONFIG_FILE="$HOME/.config/hypr/last-wallpaper.txt"

# Kill any existing mpvpaper
pkill -x mpvpaper

# Select video wallpaper
SELECTED=$(ls "$WALLPAPER_DIR" | rofi -dmenu -p "Choose wallpaper")

# Exit if nothing selected
[ -z "$SELECTED" ] && exit

# Save selected wallpaper
echo "$SELECTED" >"$CONFIG_FILE"

# Start mpvpaper
mpvpaper -o "loop-file=inf no-audio no-osc fullscreen keepaspect=no" "$MONITOR" "$WALLPAPER_DIR/$SELECTED"
