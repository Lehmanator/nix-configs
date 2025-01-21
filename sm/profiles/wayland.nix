{ config, lib, pkgs, ... }:
{
  imports = [./common-gui.nix];
  environment.systemPackages = [
    pkgs.wl-clipboard-rs        # Wayland clipboard CLI (wl-clip, wl-paste)
    pkgs.wlr-randr              # Wayland display configurator CLI
  ];
}
