{ inputs, ... }:
{ config, lib, pkgs, ... }:
{
  programs.gnome-shell.extensions = [
    { package = pkgs.gnomeExtensions.ddterm; }
  ];
}
