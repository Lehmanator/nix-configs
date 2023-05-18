{ self, inputs,
  config, lib, pkgs,
  ...
}:
{
  home.packages = [
    pkgs.megapixels             # Camera GTK app
    #pkgs.snapshot              # New GTK4 camera app
    pkgs.phosh-mobile-settings  # Settings for phosh / mobile Linux
  ];
}
