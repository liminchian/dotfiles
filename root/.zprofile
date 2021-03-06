export LANG=zh_TW.UTF-8
export LANGUAGE=zh_TW:en_US

export XIM_PROGRAM=ibus
export XIM=ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export GLFW_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startxfce4
fi

