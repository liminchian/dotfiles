#! /bin/sh

/usr/lib/systemd --user &
export DESKTOP_SESSION="i3"
export PATH=$HOME/bin:$PATH

xclip &
~/.config/xwinwrap/livewallpaper.sh &
~/.config/polybar/launch.sh &
picom &
dunst &
flameshot &
flashfocus &
ibus-daemon &
unclutter &
numlockx &
modprobe -vv nvidia &

i3
