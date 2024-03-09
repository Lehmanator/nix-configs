{ inputs, config, lib, pkgs, user, ... }: {
  imports = with inputs.self.nixosProfiles; [
    plymouth
    systemd-boot
    systemd-initrd

    #./extra-bootloader-entries.nix

    #hibernation
    #nvme
    #secureboot
    #systemd-debug
    #systemd-emergency
    #systemd-repart
    #unl0kr
    ##iscsi-initiator

    #./entries #          # ./entries/{efi-shell,fwupd,memtest86,netbootxyz,restart-bootloader,usb-boot}.nix
    #./filesystem-support # ./filesystem-support/{bcachefs,btrfs,f2fs,lvm2,mdadm,ntfs,xfs,zfs}.nix

    #./efivars.nix
    #./grub.nix
    #./tpm.nix
    #./xbootldr.nix
  ];

  boot.loader = {
    timeout = lib.mkDefault
      6; # Second until default bootloader entry boots. `null` = wait indefinitely
    # [nix-community/srvos](https://github.com/nix-community/srvos/blob/main/nixos/mixins/systemd-boot.nix) recommend enable during install only
    efi = {
      efiSysMountPoint = lib.mkDefault
        "/boot"; # "/boot/efi"; # Where EFI System Partition is mounted.
      canTouchEfiVariables = lib.mkDefault
        true; # # Whether install process allowed to modify EFI boot variables.
    };
  };
}
