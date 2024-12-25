#!/bin/bash

WATCH_DIR="$HOME/dotfiles/waybar/"

on_change() {
  pkill waybar 
  waybar &
}

inotifywait -m -e modify,create,delete,move "$WATCH_DIR" --format '%w%f' |
while read -r changed_file; do
    on_change "$changed_file"
done
