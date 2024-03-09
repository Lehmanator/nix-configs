{ inputs
, config
, lib
, pkgs
, modulesPath
, ...
}:
{
  imports = [
    ./efi-shell.nix
    ./fwupd.nix
    ./memtest86.nix
    ./netbootxyz.nix
    ./restart-bootloader.nix
    ./usb-boot.nix
  ];

  boot.loader.systemd-boot = {
    extraEntries = {
      # --- Launch Existing EFI Binaries ---
      "reboot-to-firmware-setup" = ''
        title UEFI Settings
        efi
      '';

      # --- OS Compat ---
      # https://wiki.archlinux.org/title/Dual_boot_with_Windows)
      # TODO: Entry: Windows       (must be named: `windows` OR begin with: `windows-`)
      "windows" = ''
        title Windows
        efi
      '';
      # TODO: Clover (hackintosh)
      # TODO: Entry: Ventoy?


    };

    # TODO: EFI Shell               (must be named: `efi-shell`)
    # TODO: Emergency shell target
    # TODO: Firmware Updater         (fwupd)
    # TODO: Recovery environment
    # TODO: UEFI settings            (must be named: `reboot-to-firmware-setup`)
    # TODO: USB Boot
    # TODO: Windows Boot Manager     (must be named: `windows` or begin with `windows-`)
    extraFiles = {
      #"efi/<dirName>/<efiBinaryName>.efi" = "${pkgs.<efiBinaryPackage>}/<efiBinaryName>.efi";
      #"efi/reboot-bootloader/no-plymouth.efi" = "${pkgs.systemd-boot}/systemd-boot.efi";  # TODO: Get real path
    };
  };

  # --- EFI Programs ---
  # https://netboot.xyz/docs/faq
  # TODO: Disk Partitioning

  # --- Alternate Bootloaders ---
  # TODO: Possible to chainload various bootloaders for testing?
  #   TODO: rEFInd
  #   TODO: GRUB
  #   TODO: BURG
  #   TODO: Syslinux
  #   TODO: EFISTUB
  #   TODO: ~LILO~
  #   TODO: U-Boot
  #   TODO: Tow Boot
  #   TODO: fastboot
  #   TODO: LibreBoot
  #   TODO: CoreBoot
}
