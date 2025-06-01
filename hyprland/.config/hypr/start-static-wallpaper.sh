#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers" # Change to your static wallpaper dir
CONFIG_FILE="$HOME/.config/hypr/last-static--wallpaper.txt"
MONITOR="eDP-1"
HYP_PANEL_CONFIG="$HOME/.config/hyprpanel/config"

sleep 1
pkill -x hyprpaper

if [ -f "$CONFIG_FILE" ]; then
  SELECTED=$(cat "$CONFIG_FILE")

  # Extract a single frame from static wallpaper (optional but helps pywal generate colors)
  # If your wallpapers are images, you can skip this or just use the image directly
  FRAME="$WALLPAPER_DIR/$SELECTED"

  # Generate pywal colors from the static image
  wal -i "$FRAME"

  cp "$FRAME" ~/.config/wal_frame.png

  # Source pywal colors
  source "$HOME/.cache/wal/colors.sh"

  # Apply border colors to Hyprland
  if [[ -n "$color0" && -n "$color4" ]]; then
    hyprctl keyword general:col.active_border "rgba(${color4:1}ff)"
    hyprctl keyword general:col.inactive_border "rgba(${color0:1}ff)"
    hyprctl keyword general:col.background "rgba(${color0:1}ff)"
  fi

  # Apply to Hyprpanel
  if [ -f "$HYP_PANEL_CONFIG" ]; then
    sed -i "s/^background = .*/background = $color0/" "$HYP_PANEL_CONFIG"
    sed -i "s/^foreground = .*/foreground = $color7/" "$HYP_PANEL_CONFIG"
    pkill -x hyprpanel && hyprpanel &
  fi

  # Start hyprpaper with selected wallpaper
  hyprpaper --output "$MONITOR" --image "$FRAME"

  # Run keyboard lighting script
  ~/.config/hypr/pywal-asus-keyboard.sh
fi
