{ config, lib, pkgs, ... }:
{
  imports = [
    ./mobile.nix
    ./wayland.nix
    # ./gtk.nix
  ];

  # https://wiki.postmarketos.org/wiki/Phosh
  # $ ls /sys/class/drm
  # Default: scale = 2
  environment.etc."phosh/phoc.ini".text = ''
    [output:DSI-1]
    scale = 1.5
  '';

  environment.systemPackages = [
    pkgs.phosh-mobile-settings  # Mobile-specific settings GTK GUI
  ];
  
}
