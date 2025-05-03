#!/bin/bash

# Directly set the player to Spotify
player="spotify"

# Check if the player is running and get its status
status=$(playerctl -p "$player" status)

if [ -z "$status" ]; then
  yad --text="Spotify is not running or is not detected" --width=300 --height=100 --title="Media Control" --button="OK"
  exit 1
fi

# Define control buttons
control_buttons="Play/Pause!$status\nNext!next\nPrevious!previous\nVolume Up!vol-up\nVolume Down!vol-down\nStop!stop"

# Show the media control UI using yad
action=$(echo -e "$control_buttons" | yad --list --width=300 --height=200 --column="Control" --button="Close")

# Handle actions
case "$action" in
"Play/Pause")
  playerctl -p "$player" play-pause
  ;;
"Next")
  playerctl -p "$player" next
  ;;
"Previous")
  playerctl -p "$player" previous
  ;;
"Volume Up")
  playerctl -p "$player" volume 0.1+
  ;;
"Volume Down")
  playerctl -p "$player" volume 0.1-
  ;;
"Stop")
  playerctl -p "$player" stop
  ;;
*)
  exit 0
  ;;
esac
