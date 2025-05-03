#!/bin/bash

# Source the Pywal colors
source "$HOME/.cache/wal/colors.sh"

# Apply to Hyprland using hyprctl
if [[ -n "$color0" && -n "$color4" ]]; then
  # Active border color (Window active)
  hyprctl keyword general:col.active_border "rgba(${color4:1}ff)"

  # Inactive border color (Window inactive)
  hyprctl keyword general:col.inactive_border "rgba(${color0:1}ff)"

  hyprctl keyword general:col.background "rgba(${color0:1}ff)"
fi
