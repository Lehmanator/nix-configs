{ inputs, config, lib, pkgs, user, ... }:
{
  imports = [
    ./configuration.nix # System configuration
    ./disko.nix # Disk configuration
    ./hardware-configuration.nix # Configuration related to hardware
    ./profiles.nix # Load profiles
    #./displays.nix # Handles hardware peripherals for external & internal displays
    ./managed.nix # Include configuration managed by apps: nixos-conf-editor & nix-software-center

    inputs.disko.nixosModules.disko
    inputs.srvos.nixosModules.desktop
    #inputs.srvos.nixosModules.mixins-nix-experimental
    #inputs.srvos.nixosModules.mixins-systemd-boot
    #inputs.srvos.nixosModules.mixins-trusted-nix-caches
  ];

  boot.loader.efi.efiSysMountPoint = lib.mkForce "/boot";
}
