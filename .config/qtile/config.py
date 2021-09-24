import os
from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

# Icons dir
icons = os.path.join(os.path.realpath(os.path.dirname(__file__)), "icons")

# CUSTOM VARIABLES
gaps = 5
border_width = 2

color0 = "#121212"
color1 = "#0e0a1f"
color2 = "#15121f"
color3 = "#1e143d"
color4 = "#483d5c"
color5 = "#77449e"
color6 = "#908da6"
color7 = "#8379ab"

mod = "mod1"
sup = "mod4"
terminal = "kitty"
browser = "chromium"
file_manager = "pcmanfm"
screenshot = "flameshot gui"
menu = "/home/larvasei/.config/rofi/launchers/misc/launcher.sh"
powermenu = "/home/larvasei/.config/rofi/powermenu/powermenu.sh"

keys = [
    # Switch monitors
    # Switch between windows
    Key([mod], "period", lazy.next_screen(), desc="Next monitor"),
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "Tab", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # floating move
    Key([sup, "shift"], "j", lazy.layout.flip_down()),
    Key([sup, "shift"], "k", lazy.layout.flip_up()),
    Key([sup, "shift"], "h", lazy.layout.flip_left()),
    Key([sup, "shift"], "l", lazy.layout.flip_right()),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([sup], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([sup], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([sup], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([sup], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([sup], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod],
        "s",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "grave", lazy.spawn(terminal), desc="Launch terminal"),
    Key([sup], "e", lazy.spawn(file_manager), desc="Launch file manager"),
    Key([sup], "w", lazy.spawn(browser), desc="Launch browser"),
    Key([sup], "d", lazy.spawn(menu), desc="Launch application menu"),
    Key([sup], "x", lazy.spawn(powermenu), desc="Launch powermenu"),
    Key([sup], "r", lazy.spawncmd(terminal), desc="Launch command"),
    Key([sup, "shift"], "s", lazy.spawn(screenshot), desc="Launch area screenshot"),
    # Volsup control
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn("pulseaudio-ctl up 2"),
        desc="increase volume",
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn("pulseaudio-ctl down 2"),
        desc="decrease volume",
    ),
    Key(
        [],
        "XF86AudioMute",
        lazy.spawn("pulseaudio-ctl mute"),
        desc="mute volume",
    ),
    # Media player control
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    # Toggle between different layouts as defined below
    Key([sup], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "shift"], "c", lazy.shutdown(), desc="Shutdown Qtile"),
]

groups = [Group(i) for i in "12345"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod + shift + letter of group = switch to & move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
            #     desc="Switch to & move focused window to group {}".format(i.name)),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name),
                desc="move focused window to group {}".format(i.name),
            ),
        ]
    )

# LAYOUTS
layout_style = {
    # Normal settings.
    "border_width": border_width,
    "border_normal": color3,
    "border_focus": color6,
    "border_focus_stack": color5,
    "border_on_single": True,
    "margin": gaps,
    # TreeTab settings.
    "bg_color": color0,
    "inactive_bg": color2,
    "active_bg": color5,
    "section_left": 2,
    "section_padding": 2,
    "section_top": 2,
}

layouts = [
    layout.Columns(
        grow_amount=2,
        **layout_style,
    ),
    # layout.Max(**layout_style),
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(**layout_style),
    # layout.MonadWide(**layout_style),
    # layout.RatioTile(),
    # layout.Tile(**layout_style),
    layout.TreeTab(**layout_style),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = {
    "font": "NotoSans Nerd Font",
    "fontsize": 12,
    "padding": 2,
    "background": color0,
}

extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayoutIcon(
                    custom_icon_paths=icons,
                    background=color2,
                ),
                widget.GroupBox(
                    hide_unused=False,
                    highlight_method="line",
                    this_current_screen_border=color6,
                    highlight_color=[color2, color2],
                    rounded=False,
                ),
                widget.Prompt(),
                widget.WindowName(background=color0, padding=8),
                widget.Sep(foreground=color2, padding=5),
                widget.Image(filename=os.path.join(icons, "ram.png")),
                widget.Memory(
                    measure_mem="G",
                    format="{MemUsed:.1f}{mm}/{MemTotal:.1f}{mm}",
                    fontsize=12,
                    background=color2,
                ),
                widget.Sep(foreground=color2, padding=5),
                widget.Image(filename=os.path.join(icons, "sound.png")),
                widget.PulseVolume(
                    background=color2,
                ),
                widget.Sep(foreground=color2, padding=5),
                widget.Image(filename=os.path.join(icons, "calendar.png")),
                widget.Clock(format="%Y-%m-%d(%A) %H:%M:%S", background=color2),
                widget.Sep(foreground=color2, padding=5),
                widget.Systray(icon_size=14),
            ],
            16,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
    Click([mod, "shift"], "Button1", lazy.window.toggle_floating()),
]

dgroups_key_binder = None
dgroups_app_rules = []
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ],
    **layout_style,
)
auto_fullscreen = True
focus_on_window_activation = "smart"

wmname = "LG3D"
