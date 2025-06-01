#!/bin/bash

# Extract pywal color1 hex code without '#'
COLOR_HEX=$(jq -r '.colors.color1' ~/.cache/wal/colors.json | tr -d '#')

echo "Setting keyboard lighting to color: $COLOR_HEX"

# Set keyboard RGB color via asusctl aura static
asusctl aura static -c $COLOR_HEX
