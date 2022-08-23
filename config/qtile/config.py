import os
import subprocess
from typing import List
from libqtile import bar, layout, widget
from libqtile import hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

# -----------------------------------------------------------------------------

# Variables
mod = "mod1"
terminal = "kitty"
browser = "google-chrome"
spotify = "spotify"
# -----------------------------------------------------------------------------

# Keybindings

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "p", lazy.layout.next()),
    
    Key([mod], "Left", lazy.layout.left()),
    Key([mod], "Right", lazy.layout.right()),
    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "Up", lazy.layout.up()),

    # Move windows
    Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    
    # Resize windows
    Key([mod, "control"], "h", lazy.layout.grow_left()),
    Key([mod, "control"], "l", lazy.layout.grow_right()),
    Key([mod, "control"], "j", lazy.layout.grow_down()),
    Key([mod, "control"], "k", lazy.layout.grow_up()),
    
    Key([mod, "control"], "Left", lazy.layout.grow_left()),
    Key([mod, "control"], "Right", lazy.layout.grow_right()),
    Key([mod, "control"], "Down", lazy.layout.grow_down()),
    Key([mod, "control"], "Up", lazy.layout.grow_up()),
    
    # Get windows original size
    Key([mod], "n", lazy.layout.normalize()),
    
    # Toggle between split and unsplit sides of stack
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
    ),
    # Browser
    Key([mod], "b", lazy.spawn(browser)),
    
    # Terminal
    Key([mod], "Return", lazy.spawn(terminal)),
    
    # Launcher
    Key([mod], "space", lazy.spawn("rofi -show drun")),
    
    # File Browser
    Key([mod], "f", lazy.spawn(f"{terminal} ranger")),
    
    # Spotify 
    Key([mod], "s", lazy.spawn(spotify)),
    
    # Toogle layout
    Key([mod], "Tab", lazy.next_layout()),
    
    # Kill window
    Key([mod], "x", lazy.window.kill()),
    
    # Reload Qtile
    Key([mod, "shift"], "r", lazy.reload_config()),
    
    # Exit Qtile
    Key([mod, "shift"], "e", lazy.shutdown()),
    
]
# -----------------------------------------------------------------------------

# Workspaces

groups = [
    Group(i)
    for i in [
        "  ",
        "  ",
        "   ",
        "   ",
        "   ",
    ]
]

for i, group in enumerate(groups):
    actual_key = str(i + 1)
    keys.extend(
        [
            # Switch to workspace N
            Key([mod], actual_key, lazy.group[group.name].toscreen()),
            # Send window to workspace N
            Key([mod, "shift"], actual_key, lazy.window.togroup(group.name)),
        ]
    )
# -----------------------------------------------------------------------------

# Window style in layout

layouts = [
    layout.MonadTall(
        border_focus="#414868", 
        border_normal="#282a2e", 
        border_width=1, 
        margin=8,
    ),
    layout.Max(),
    
    layout.Bsp(
        border_focus="#414868", 
        border_normal="282a2e", 
        border_width=1, 
        margin=8
    ),
    
    layout.MonaWide(
        border_focus="414868", 
        border_normal="282a2e", 
        border_width=1, 
        margin=8
    ),
    
    layout.RatioTile(
        border_focus="414868", 
        border_normal="282a2e", 
        border_width=1, 
        margin=8
    ),
]
# -----------------------------------------------------------------------------

# Bar

widget_defaults = dict(
    font="UbuntuMono Nerd Font",
    fontsize=16,
    padding=6,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Sep(linewidth=0,
                           padding=6),
                
                widget.Sep(linewidth=0, padding=6),
                
                widget.GroupBox(
                    active="#c0caf5",
                    rounded=False,
                    highlight_color="#bb9af7",
                    highlight_method="line",
                    borderwidth=0,
                    disable_drag=True,
                ),
                
                widget.WindowName(
                    foreground="#f7768e",
                    markup=True,
                    font="UbuntuMono Nerd Font",
                    fontsize=14,
                    max_chars=63,
                ),
                
                widget.TextBox(
                    text='',
                    font='UbuntuMono Nerd Font',
                    foreground='#282a2e',
                    fontsize=57,
                    padding=0,
                ),
                
                widget.TextBox(
                    text=' ',
                    font='UbuntuMono Nerd Font',
                    foreground='#f7768e',
                    fontsize=14,
                ),
                
                widget.OpenWeather(
                    language='pt_br',
                    app_key='3585631a5a665198e266fb87955cd179',
                    location='Curitiba',
                    update_interval=600,
                    format='{location_city}: {main_temp} °{units_temperature}',
                ),
                
                widget.Systray(
                    icon_size=20,
                    padding=6,
                    ),
                
                widget.TextBox(
                    text=' ',
                    font='UbuntuMono Nerd Font',
                    foreground='#f7768e',
                    fontsize=14,
                ),
                
                widget.Clock(format='%A, %d-%m-%Y'),
                
                widget.TextBox(
                    text=' ',
                    font='UbuntuMono Nerd Font',
                    foreground='#f7768e',
                    fontsize=14,
                ),
                
                widget.Clock(format='%H:%M'),
            ],
            25,
            background='#282a2e',
        ),
    ),
]
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]
# -----------------------------------------------------------------------------

# Floating windows

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
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
    border_focus="#414868",
    border_normal="#282a2e"
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True
