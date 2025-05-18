#!/bin/bash

WALLPAPER_DIR="$HOME/Videos/live-Wallpaper"
CONFIG_FILE="$HOME/.config/hypr/last-wallpaper.txt"
MONITOR="eDP-1"
HYP_PANEL_CONFIG="$HOME/.config/hyprpanel/config"

sleep 1
pkill -x mpvpaper

if [ -f "$CONFIG_FILE" ]; then
  SELECTED=$(cat "$CONFIG_FILE")

  STAMP=$(date +%s)
  FRAME="/tmp/wal_frame_$STAMP.png"
  ffmpeg -y -i "$WALLPAPER_DIR/$SELECTED" -ss 00:00:02 -vframes 1 "$FRAME"
  wal -i "$FRAME"

  cp "$FRAME" ~/.config/wal_frame.png

  find /tmp -maxdepth 1 -name 'wal_frame_*.png' -min +5 -delete

  source "$HOME/.cache/wal/colors.sh"
  hyprctl keyword general:col.active_border "rgba(${color4:1}ff)"
  hyprctl keyword general:col.inactive_border "rgba(${color0:1}ff)"

  if [ -f "$HYP_PANEL_CONFIG" ]; then
    sed -i "s/^background = .*/background = $color0/" "$HYP_PANEL_CONFIG"
    sed -i "s/^foreground = .*/foreground = $color7/" "$HYP_PANEL_CONFIG"
    pkill -x hyprpanel && hyprpanel &
  fi

  mpvpaper -o "loop-file=inf no-audio no-osc fullscreen keepaspect=no" "$MONITOR" "$WALLPAPER_DIR/$SELECTED"
  ~/.config/hypr/pywal-asus-keyboard.sh
  ~/.config/hypr/generate-chrome-theme.sh >>~/.config/hypr/theme-update.log 2>&1
fi
