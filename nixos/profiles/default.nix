{
  inputs,
  config,
  lib,
  pkgs,
  user,
  ...
}:
# TODO: Move all config that isn't NixOS-specific stuff to common file
{
  imports = [
    ../../common/profiles

    ./modules

    ./boot
    ./hardware
    ./locale
    ./network
    ./nix
    ./security
    ./shell
    ./users
    #./desktop
    #./generators
    #./installer
    #./virt

    ./adb.nix
    ./motd.nix
    ./normalize.nix
    ./sshd.nix
    #./auto-upgrade.nix
    #./specialization.nix
    #./stylix.nix

    #inputs.srvos.nixosModules.common
    #inputs.srvos.nixosModules.mixins-nix-experimental
    #inputs.srvos.nixosModules.mixins-trusted-nix-caches
    #
    #inputs.nix-data.nixosModules.nix-data
    #inputs.nix-index.nixosModules.nix-index { programs.nix-index-database.comma.enable = true; }
    #./nix/activation-script.nix
    #./boot
    #./home-manager.nix
    #./users/homed.nix
  ];

  # Mount /etc via overlay filesystem (faster activation)
  system.etc.overlay = {
    enable = lib.mkDefault true;
    mutable = lib.mkDefault true;
  };

  # Enable extra info/metadata for packages
  appstream.enable = true;

  # Always load modules: USB controller, NVMe controller, SATA controller, USB gadgets/peripherals
  boot.initrd.availableKernelModules = ["xhci_pci" "nvme" "ahci" "usbhid" "usb_storage"];
}
