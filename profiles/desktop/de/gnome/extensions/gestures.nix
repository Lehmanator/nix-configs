{ inputs
, config
, lib
, pkgs
, user
, ...
}:
{
  users.users.${user}.extraGroups = [ "input" ]; # Needed for X11 gesture extension support
  environment.systemPackages = with pkgs.gnomeExtensions; [
    # Touchpad gesutre improvements on Wayland/X11
    # https://github.com/harshadgavali/gnome-gesture-improvements
    # - X11 requires: https://github.com/harshadgavali/gnome-x11-gesture-daemon
    # - Switch window:         3-finger-horizontal  desktop
    # - Switch workspace:      4-finger-horizontal  anywhere
    # - Switch workspace:    2/3-finger-horizontal  overview
    # - Switch app page:     2/3-finger-horizontal  app grid
    # - Overview/Grid/Desktop: 4-finger-vertical    anywhere
    # - Max/Unmax/Fullscreen:  3-finger-vertical    desktop
    # - Minimize window:       3-finger-vertical    desktop
    pkgs.gnomeExtensions.gesture-improvements
  ];
}
