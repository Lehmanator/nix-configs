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

    ./firefox/default.nix

    #./browsers-librewolf.nix
    #./browsers-tor.nix
    #./browsers-ungoogledchromium.nix
  ];

  home.packages = with pkgs; [
    #pkgs.ungoogled-chromium
    pkgs.chromium
    #pkgs.chromiumBeta
    #pkgs.chromiumDev
    pkgs.tor-browser-bundle-bin
  ];

  # https://gist.github.com/quidome/4e225db4b1611a9624d3927919f96bc6
  #config = lib.mkIf (cfg.desktopManager.gnome.enable == true) {
  #  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
  #  '';
  #};
}
