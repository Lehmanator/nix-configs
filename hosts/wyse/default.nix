{ inputs, config, lib, pkgs, user, ... }:
{
  imports = [
    inputs.srvos.nixosModules.desktop
    inputs.srvos.nixosModules.mixins-nix-experimental
    inputs.srvos.nixosModules.mixins-systemd-boot
    inputs.srvos.nixosModules.mixins-trusted-nix-caches
    ./configuration.nix # System configuration
    ./disko.nix # Disk configuration
    ./hardware-configuration.nix # Configuration related to hardware
    #./snowflake.nix # Uses some stuff from SnowflakeOS
    #./displays.nix # Handles hardware peripherals for external & internal displays
    ./managed.nix # Include configuration managed by apps: nixos-conf-editor & nix-software-center
  ];
}
