{ inputs, config, lib, pkgs, ... }:
{
  imports = [ ];

  environment.systemPackages = [ pkgs.gnomeExtensions.pano ];
  services.xserver.desktopManager.gnome.sessionPath = [
    pkgs.gsound
    pkgs.libgda6
  ];
}
