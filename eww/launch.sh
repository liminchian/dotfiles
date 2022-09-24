#!/bin/sh

## Files and cmd
FILE1="$HOME/.cache/eww_launch.sidebar"
EWW=$(which eww)

## Run eww daemon if not running already
if [ ! "$(pidof eww)" ]; then
	${EWW} daemon
	sleep 1
fi

## Open widgets
run_eww() {
	${EWW} open-many sidebar bar
}

weather() {
	~/.config/eww/scripts/weather --getdata
}

## Launch or close widgets accordingly
if [ ! -f "$FILE1" ]; then
	touch "$FILE1"
	run_eww
else
	${EWW} close \
		sidebar \
		bar
	rm "$FILE1"
fi
