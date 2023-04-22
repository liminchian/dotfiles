if status is-interactive
    # Commands to run in interactive sessions can go here
end

if status --is-login
  if test -z "$DISPLAY" && test "$(tty)" = "/dev/tty1"
    set -gx LANG zh_TW.UTF-8
    set -gx LIBVA_DRIVER_NAME nvidia
    set -gx XDG_SESSION_TYPE wayland
    set -gx QT_WAYLAND_DISABLE_WINDOWDECORATION 1
    set -gx MOZ_ENABLE_WAYLAND 1
    set -gx GDK_BACKEND wayland
    set -gx GBM_BACKEND nvidia-drm
    set -gx WLR_NO_HARDWARE_CURSORS 1
    set -gx CLUTER_BACKEND wayland
    set -gx QT_QPA_PLATFORM wayland

    set -gx XCURSOR_SIZE 24
    set -gx DESKTOP_SESSION Hyprland
    set -gx JUPYTERLAB_DIR $HOME/.local/share/jupyter/lab
    set -gx SKIM_DEFAULT_OPTIONS "--ansi --regex"
    set -gx AUTOJUMP_PATH $HOME/.autojump/share/autojump/autojump.fish
    set -gx RUST_BACKTRACE full

    set -gx GTK_IM_MODULE fcitx
    set -gx QT_IM_MODULE fcitx
    set -gx SDL_IM_MODULE fcitx
    set -gx GLFW_IM_MODULE ibus
    set -gx OBSIDIAN $HOME/Desktop/obsidian-notes
    set -gx HYPRLAND_LOG_WLR 1

    exec Hyprland
  end
end

if test -e "$AUTOJUMP_PATH"
  source "$AUTOJUMP_PATH"
end

fish_add_path ~/.local/bin ~/.local/share ~/.local/bin/scripts ~/.surrealdb
set find_key_bindings fish_user_key_bindings
set fish_cursor_default     block
set fish_cursor_insert      line      
set fish_cursor_replace_one underscore
set fish_cursor_visual      block
set -g fish_escape_delay_ms    100

starship init fish | source
