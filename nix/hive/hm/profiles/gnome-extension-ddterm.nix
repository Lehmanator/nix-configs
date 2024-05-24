{ inputs, cell, config, lib, pkgs, ... }: {
  home.packages = [
    pkgs.gnomeExtensions.ddterm
    # Deps
    pkgs.gjs
    pkgs.libhandy
    pkgs.vte-gtk4
    pkgs.vte
  ];
}
