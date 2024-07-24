{ inputs, config, lib, pkgs, user, ... }:
let
  scripts = {
    check-generations =  "sudo sbctl verify /boot/EFI/Linux/nixos-generation-*.efi";
  };
in
{
  # https://github.com/nix-community/lanzaboote
  imports = [ 
    inputs.lanzaboote.nixosModules.lanzaboote
    # inputs.lanzaboote.nixosModules.uki
  ];

  boot = {
    lanzaboote = {
      enable = lib.mkDefault true;
      pkiBundle = lib.mkDefault "/etc/secureboot";
      # pkiBundle = lib.mkDefault config.skjkjops.secrets.secureboot-keys.path;
    };
    loader.systemd-boot.enable = lib.mkForce false;  #lib.mkForce (!lanzaboote.enable);
  };

  # For debugging and troubleshooting Secure Boot.
  environment.systemPackages = [ pkgs.sbctl ];

  # sops.secrets.secureboot = lib.mkIf config.boot.lanzaboote.enable {
  #   sopsFile = ../../hosts/${config.networking.hostName}/secrets/secureboot.yaml;
  #   path = "/etc/secureboot";
  #   owner = "root";
  #   group = "root";
  # };


  # TODO: impermanence: persist /etc/secureboot
  # TODO: Learn about `lib.extendModules`
}
