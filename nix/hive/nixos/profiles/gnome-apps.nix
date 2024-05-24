{ inputs, cell, config, lib, pkgs, ... }:
# Default apps for GNOME configuration
{
  imports = [
    #./epiphany.nix
    #./dev.nix
    #./email.nix
    #./remote.nix
  ];
  environment.systemPackages = [
    pkgs.authenticator # GTK4 Two-Factor Auth code generator
    pkgs.gnome.gnome-software
  ];

  programs.evince.enable = true;

  services.gnome = {
    core-utilities.enable = true;
    games.enable = true;
    gnome-remote-desktop.enable = true;
    sushi.enable = true; # Nautilus previewer
  };
}
