{ config, lib, pkgs, ... }:
{
  # TODO: Configure home-manager
  # Show performance/load/sensor info in panel
  environment.systemPackages = [pkgs.gnomeExtensions.vitals];

  services.xserver.desktopManager.gnome.sessionPath = [
    pkgs.gtop
    pkgs.libgtop
    pkgs.libnotify
    pkgs.lm_sensors
  ];
}
