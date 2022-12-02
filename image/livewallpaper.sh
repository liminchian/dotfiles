#!/bin/bash

FILE="$HOME/.cache/mpvpaper.xyz"
VIDEO="$HOME/.config/image/chill.mp4"

run() {
	mpvpaper -spf -o "input-ipc-server=/tmp/mpv-socket no-audio --loop-playlist --shuffle" HDMI-A-1 "$VIDEO"
}

if [[ ! $(pidof mpvpaper) ]]; then
	if [[ ! -f "$FILE" ]]; then
		touch "$FILE"
	fi
	run
else
	pkill mpvpaper
	rm "$FILE"
fi
