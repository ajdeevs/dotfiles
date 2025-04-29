#!/bin/bash

WALLPAPER_DIR="$HOME/Videos/live-Wallpaper"
MONITOR="eDP-1"
CONFIG_FILE="$HOME/.config/hypr/last-wallpaper.txt"

# Wait for Hyprland to fully load
sleep 1

# Kill any existing mpvpaper
pkill -x mpvpaper

# Load last selected wallpaper if it exists
if [ -f "$CONFIG_FILE" ]; then
  WALLPAPER=$(cat "$CONFIG_FILE")
  mpvpaper -o "loop-file=inf no-audio no-osc fullscreen keepaspect=no" "$MONITOR" "$WALLPAPER_DIR/$WALLPAPER"
fi
