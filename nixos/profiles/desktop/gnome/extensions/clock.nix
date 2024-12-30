{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs.gnomeExtensions; [
    # Tasks lists in clock panel next to calendar
    # - Local tasks
    # - Endeavour (Tasks app)
    # - Evolution (Mail client)
    # - GNOME Online Accounts (all providers that support tasks)
    # - Thunderbird (Mail client)
    # task-widget     # Clock panel task list next to calendar (Srcs: Local, Endeavour, Evolution, GNOME Online Accounts, Thunderbird)
    desktop-clock     # Display configurable desktop clock
    weather-or-not    # Display clickable weather status panel button next to clock
  ];

}
