{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  # https://github.com/nix-community/lanzaboote
  imports = [inputs.lanzaboote.nixosModules.lanzaboote];
  #home-manager.sharedModules = [ inputs.lanzaboote.homemManagerModules.lanzaboote ]; # No hmModule yet

  #boot = {
  #  lanzaboote = {
  #    enable = lib.mkDefault true;
  #    #pkiBundle = lib.mkDefault config.sops.secrets.secureboot-keys.path;
  #  };
  #  loader.systemd-boot.enable = lib.mkForce false;  #lib.mkForce (!lanzaboote.enable);
  #};

  environment.systemPackages = [
    # For debugging and troubleshooting Secure Boot.
    pkgs.sbctl
  ];

  sops.secrets.secureboot-keys =
    lib.mkIf config.boot.lanzaboote.enable {path = "/etc/secureboot";};

  # TODO: Learn about `lib.extendModules`
}
