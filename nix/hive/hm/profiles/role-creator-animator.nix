{ config, lib, pkgs , ... }: {
  # imports = [ ];
  home.packages = [ pkgs.gimp-with-plugins pkgs.gimpPlugins.gap ];
}
