{ inputs, cell, config, lib, pkgs, ... }: {
  programs.gnome-shell.extensions = [{
    package = pkgs.gnomeExtensions.ddterm;
  }];

  # Make deps available.
  # TODO: Check if working properly
  home.packages = [
    pkgs.gjs
    pkgs.libhandy
    pkgs.vte-gtk4
    # pkgs.vte
  ];

  # TODO: Dconf settings
}
