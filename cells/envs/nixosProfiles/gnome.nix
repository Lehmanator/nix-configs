{ pkgs, ... }:
{
  imports = [];

  boot.plymouth.enable = true;
  networking.networkmanager.enable = true;
  powerManagement.enable = true;

  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
  };

  # Adds terminus_font for people with HiDPI displays
  console.packages = [ pkgs.terminus_font ];


}
