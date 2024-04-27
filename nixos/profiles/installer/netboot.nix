{ inputs, config, lib, pkgs, ... }:
{
  # https://github.com/nix-community/nixos-images/blob/main/flake.nix
  # TODO: kexec-installer, kexec-installer-gnome, netboot-installer-gnome, install-iso-gnome
  formatConfigs.netboot-installer = {
    imports = [
      inputs.nixos-images.nixosModules.netboot-installer
      #inputs.nixos-images.nixosModules.noninteractive
    ];
    disko.enableConfig = lib.mkForce false;
    networking.hostName = lib.mkForce "${config.networking.hostName}-installer";
  };

}
