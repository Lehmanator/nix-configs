{ config, lib, pkgs, ... }:
{
  # TODO: Create custom terminal launcher.desktop for Quake Terminal
  # TODO: Exempt this launcher from Forge tiling
  environment.systemPackages = [
    pkgs.gnomeExtensions.ddterm
    pkgs.gnomeExtensions.quake-terminal
    pkgs.alacritty
  ];
  services.xserver.desktopManager.gnome.sessionPath = [
    pkgs.vte
    pkgs.vte-gtk4
    pkgs.gobject-introspection
    pkgs.gtk3
    pkgs.gtk4
    pkgs.gdk-pixbuf
    pkgs.glib
    pkgs.glibc
    # pkgs.gi-gio
    # pkgs.gi-glib
    # pkgs.gi-gmodule
    # pkgs.gi-gobject
    pkgs.libhandy
    pkgs.libhandy_0
  ];
}
