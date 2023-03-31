{
  self, 
  modulesPath,
  inputs, outputs,
  config, lib, pkgs,
  ...
}:
let
  cfg = config.services.xserver;
in
{
  imports = [
    #./browsers-chromium.nix
    #./browsers-epiphany.nix

    ./browsers-firefox.nix

    #./browsers-librewolf.nix
    #./browsers-tor.nix
    #./browsers-ungoogledchromium.nix
  ];

  home.packages = with pkgs; [
  ];

  # https://gist.github.com/quidome/4e225db4b1611a9624d3927919f96bc6
  #config = lib.mkIf (cfg.desktopManager.gnome.enable == true) {
  #  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
  #  '';
  #};
}
