# Environment variable settings.
typeset -U PATH path
path=(
  "$HOME/.local/bin"
  "$HOME/.oh-my-zsh/plugins"
  "$HOME/.oh-my-zsh/custom/plugins"
  "$path[@]"
)
export PATH
. "$HOME/.cargo/env"

# Wayland settings.
export MOZ_ENABLE_WAYLAND=1
export XDG_CURRENT_DESKTOP=Unity
export WINIT_UNIX_BACKEND=x11

# Optional settings.
export TERMINAL=alacritty
export EDITOR=nvim
export RUST_BACKTRACE=full
export JUPYTERLAB_DIR=$HOME/.local/share/jupyter/lab
export DESKTOP_SESSION=sway
export SKIM_DEFAULT_OPTIONS="--ansi --regex"
