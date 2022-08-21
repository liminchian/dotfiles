# Language setting.
export LANG=zh_TW.UTF-8

# export GTK_IM_MODULE=fcitx
# export QT_IM_MODULE=fcitx
# export XMODIFIERS=@im=fcitx
# export GLFW_IM_MODULE=fcitx

# Start Xorg server.
# if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
#   exec startx
# fi

# Start Sway window manager.
if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  exec sway
fi
