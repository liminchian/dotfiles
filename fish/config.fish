if status is-interactive
    # Commands to run in interactive sessions can go here
end

if status is-login
  if test -z "$DISPLAY" && test "$(tty)" = "/dev/tty1"
    set -gx LANG zh_TW.UTF-8
    set -gx PATH $PATH ~/.local/bin
    exec Hyprland
  end
end

fish_add_path -p ~/.bashrc ~/.bash_profile /etc/profile /etc/bash.bashrc

set -gx LIBVA_DRIVER_NAME nvidia
set -gx XDG_SESSION_TYPE wayland
set -gx QT_WAYLAND_DISABLE_WINDOWDECORATION 1
set -gx MOZ_ENABLE_WAYLAND 1
set -gx GDK_BACKEND wayland
set -gx GBM_BACKEND nvidia-drm
set -gx __GLX_VENDOR_LIVRARY_NAME nvidia
set -gx WLR_NO_HARDWARE_CURSORS 1
set -gx CLUTER_BACKEND wayland
set -gx QT_QPA_PLATFORM wayland

set -gx GDK_SCALE 1
set -gx XCURSOR_SIZE 20
set -gx RUST_BACKTRACE full
set -gx DESKTOP_SESSION Hyprland
set -gx JUPYTERLAB_DIR $HOME/.local/share/jupyter/lab
set -gx SKIM_DEFAULT_OPTIONS "--ansi --regex"

set find_key_bindings fish_user_key_bindings
set fish_cursor_default     block      blink
set fish_cursor_insert      line       blink
set fish_cursor_replace_one underscore blink
set fish_cursor_visual      block

starship init fish | source
