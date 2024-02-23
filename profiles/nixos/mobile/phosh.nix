{ inputs, config, lib, pkgs, user, ... }:
{
  #imports = [ ./gtk-apps.nix ];
  services.xserver.desktopManager = {
    gnome.enable = lib.mkDefault false;
    phosh = {
      inherit user;
      enable = true;
    };
  };
}
