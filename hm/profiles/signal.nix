{ inputs, config, lib, pkgs, ... }:
{
  # pkgs.axolotl
  home.packages = [
    pkgs.signal-desktop
  ] ++ lib.optional config.programs.gnome-shell.enable pkgs.flare-signal;

}
