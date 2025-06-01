#!/bin/bash

WALL_DIR="$HOME/Pictures/wallpapers"
CONFIG="$HOME/.config/hypr/hyprpaper.conf"
HYPRLOCK_CONF="$HOME/.config/hypr/hyprlock.conf"
MONITOR="eDP-1"

# Select wallpaper using rofi
SELECTED=$(ls "$WALL_DIR" | grep -E '\.(jpg|png|jpeg)$' | rofi -dmenu -p "Select wallpaper:")
[ -z "$SELECTED" ] && echo "No selection made" && exit 1

WALL_PATH="$WALL_DIR/$SELECTED"

# Update hyprpaper config
echo "preload = $WALL_PATH" >"$CONFIG"
echo "wallpaper = $MONITOR,$WALL_PATH" >>"$CONFIG"

# Restart hyprpaper
pkill hyprpaper
hyprpaper &

sleep 0.5

# Apply Pywal theme
wal -i "$WALL_PATH"

# Apply Hyprland border colors
if [[ -f "$HOME/.cache/wal/colors.sh" ]]; then
  source "$HOME/.cache/wal/colors.sh"
  hyprctl keyword general:col.active_border "rgba(${color4:1}ff)"
  hyprctl keyword general:col.inactive_border "rgba(${color0:1}ff)"
fi

# === Update hyprlock config ===
if [[ -f "$HYPRLOCK_CONF" ]]; then
  # Update background image
  sed -i "s|^\( *path *= *\).*|\1$WALL_PATH|" "$HYPRLOCK_CONF"

  # Optional: Update colors using pywal
  if [[ -f "$HOME/.cache/wal/colors.sh" ]]; then
    source "$HOME/.cache/wal/colors.sh"

    [ -z "$color0" ] && color0="#1e1e2e"
    [ -z "$color4" ] && color4="#89b4fa"
    [ -z "$color7" ] && color7="#ffffff"

    sed -i "s/^ *color = .*/color = rgba(${color0:1}ee)/" "$HYPRLOCK_CONF"
    sed -i "s/^ *verify_color = .*/verify_color = rgba(${color4:1}ff)/" "$HYPRLOCK_CONF"
    sed -i "s/^ *wrong_color = .*/wrong_color = rgba(ff5555ff)/" "$HYPRLOCK_CONF"
    sed -i "s/^ *text_color = .*/text_color = rgba(${color7:1}ff)/" "$HYPRLOCK_CONF"
  fi

  echo "Hyprlock image and colors updated."
fi

echo "Wallpaper set to $WALL_PATH"
~/.config/hypr/pywal-asus-keyboard.sh
