{ inputs, config, lib, pkgs, ... }: {
  imports = [
    #inputs.mobile.homeManagerModules.?
    #inputs.self.homeProfiles.app-gnome-megapixels
    #inputs.self.homeProfiles.app-gnome-snapshot
    #inputs.self.homeProfiles.app-gnome-phosh-mobile-settings
  ];

  home.packages = [
    pkgs.megapixels # Camera GTK app
    #pkgs.snapshot              # New GTK4 camera app
    pkgs.phosh-mobile-settings # Settings for phosh / mobile Linux
  ];
}
