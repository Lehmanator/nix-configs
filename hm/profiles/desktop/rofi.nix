{ inputs, config, lib, pkgs, ... }:
{
  home.packages = [
    # TODO: https://github.com/Git-Fal7/gtk-rofi
    pkgs.rofi
  ];
}
