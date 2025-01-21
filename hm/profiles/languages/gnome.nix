{ config, lib, pkgs, ... }:
{
  home.packages = [
    pkgs.blueprint-compiler
    pkgs.flatpak-builder
    pkgs.gjs
    pkgs.mesonlsp
  ] ++ lib.optionals config.programs.gnome-shell.enable [
    # pkgs.workbench
    pkgs.cambalache
    pkgs.gnome-builder
  ];
  programs.helix.extraPackages = [
    pkgs.blueprint-compiler
    pkgs.gjs
    pkgs.mesonlsp
  ];
  programs.zed-editor = {
    extensions = ["blueprint"];
    # extraPackages = [
    #   pkgs.blueprint-compiler
    #   pkgs.mesonlsp
    # ];
  };
}
