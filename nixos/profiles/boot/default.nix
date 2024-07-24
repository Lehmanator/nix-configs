{ config, lib, pkgs, user, ... }:
let
  inherit (lib) mkDefault;
in
{
  imports = [
    ./plymouth.nix
    ./systemd-boot.nix
    ./systemd-initrd.nix

    #./disko.nix
    #./extra-bootloader-entries.nix
    #./hibernation.nix
    #./iscsi-initiator.nix
    #./nvme.nix
    #./print-config-install.nix
    #./secureboot.nix
    #./systemd-debug.nix
    #./systemd-emergency.nix
    #./systemd-repart.nix
    #./unl0kr.nix

    #./entries #          # ./entries/{efi-shell,fwupd,memtest86,netbootxyz,restart-bootloader,usb-boot}.nix
    #./filesystem-support # ./filesystem-support/{bcachefs,btrfs,f2fs,lvm2,mdadm,ntfs,xfs,zfs}.nix

    #./efivars.nix
    #./tpm.nix
    #./xbootldr.nix
  ];

  boot = {
    bootspec = {
      # Write bootspec docs for each build.
      enable = mkDefault true;

      # Validate bootspec documents upon each build.
      # - Note: introduces build-time Golang dep Cuelang.
      # - Warn: Make certain bootspec docs are correct.
      enableValidation = mkDefault true;

      # extensions = {}; 
    };

    loader = {
      # Second until default bootloader entry boots.
      # - `null` = wait indefinitely
      timeout = mkDefault 6;
      # [nix-community/srvos](https://github.com/nix-community/srvos/blob/main/nixos/mixins/systemd-boot.nix) recommend enable during install only

      efi = {
        # Where to mount the EFI system partition
        efiSysMountPoint     = mkDefault "/boot"; #"/boot/efi";

        # Whether install process allowed to modify EFI boot variables
        canTouchEfiVariables = mkDefault true; 
      };
    };
  };
}
