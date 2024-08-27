{ cell, config, lib, pkgs, ... }: {
  imports = [
    #inputs.mobile.homeManagerModules.?
    #cell.homeProfiles.gnome-app-megapixels
    #cell.homeProfiles.gnome-app-snapshot
    #cell.homeProfiles.gnome-app-phosh-mobile-settings
  ];

  home.packages = [
    pkgs.megapixels  # GTK camera app (old)
    pkgs.snapshot    # GTK4 camera app (new)
    pkgs.phosh-mobile-settings # Settings for phosh / mobile Linux
  ];
}
