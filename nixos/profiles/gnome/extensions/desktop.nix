{ config, lib, pkgs, ... }:
{
  # GNOME Shell Extensions for the desktop & widgets
  environment.systemPackages = with pkgs.gnomeExtensions; [
    # Create desktop shortcuts w/ right-click -> 'add to desktop'
    # TODO: Check if desktop-icons extension provides this functionality
    add-to-desktop

    # Widgets for calendar, CPU usage, network speed, & more
    #circular-widgets

    # Clock widget on desktop
    desktop-clock

    # Lyrics of playing song on desktop
    desktop-lyric

    #desktop-icons-ng-ding    # Desktop Icons NG fork w enhancements
    #desktop-icons-neo        # Desktop Icons NG fork w shapes,corners,perf
    # Desktop Icons (GTK4 fork of desktop-icons-ng)
    # - Works best on Wayland
    # - Nautilus drag & drop
    # - Supports GSConnect
    gtk4-desktop-icons-ng-ding

    # Add overlays to wallpapers
    #wallpaper-overlay
  ];

}
