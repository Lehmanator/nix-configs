{ cell, config, lib, pkgs, ... }: {
  imports = [
    #inputs.mobile.homeManagerModules.?
    #cell.homeProfiles.app-gnome-megapixels
    #cell.homeProfiles.app-gnome-snapshot
    #cell.homeProfiles.app-gnome-phosh-mobile-settings
  ];

  home.packages = [
    pkgs.megapixels # Camera GTK app
    #pkgs.snapshot              # New GTK4 camera app
    pkgs.phosh-mobile-settings # Settings for phosh / mobile Linux
  ];
}
