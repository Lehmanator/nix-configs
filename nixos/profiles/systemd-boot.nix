{ config, lib, pkgs, ... }: {

  #imports = [ inputs.srvos.nixosModules.mixins-systemd-boot ];
  boot.loader.systemd-boot = {
    enable = lib.mkDefault true;

    # Max generations in boot menu. Prevent boot partition from running out of space
    configurationLimit = lib.mkDefault 20;

    # Console resolution
    #   Options:
    #   - keep (keep mode selected by firmware)
    #   - max (pick highest-numbered available mode)
    #   - auto (auto-pick using heuristics)
    #   - "2" (1st non-standard mode provided by firmware if any) 
    #   - "1" (80x50)
    #   - "0" (UEFI 80x25)
    #consoleMode = lib.mkDefault "keep";

    # Allow editing bootloader entries. (Default: true (for compat), Recommended/Hardened: false)
    editor = lib.mkDefault false;

    # Invoke bootctl install with the --graceful option, which ignores errors when:
    # - EFI variables cannot be written 
    # - EFI System Partition cannot be found.
    # Notes:
    # - Currently only applies to random seed operations.
    # - Only enable this option if systemd-boot otherwise fails to install,
    #   as the scope or implication of the --graceful option may change in the future.
    graceful = lib.mkDefault false;

    # --- EFI Binaries ---
    # memtest86 = {
    #   enable = memtest;   # Memory testing util.
    #   entryFilename = "X-memtest86.conf";   # systemd-boot orders menu entries by config filenames. So make sure alphabetically after `nixos` if you want normal boot as first option.
    # };
    # netbootxyz = {
    #   enable = netboot;
    #   entryFilename = "X-netbootxyz.conf";  # See above ^^ (memtest86)
    # };

    # --- Extras ---
    # TODO: EFI Shell               (must be named: `efi-shell`)
    # TODO: Emergency shell target
    # TODO: Firmware Updater         (fwupd)
    # TODO: Recovery environment
    # TODO: UEFI settings            (must be named: `reboot-to-firmware-setup`)
    # TODO: USB Boot
    # TODO: Windows Boot Manager     (must be named: `windows` or begin with `windows-`)
    # extraFiles = {
    #   "efi/memtest86/memtest.efi" = "${pkgs.memtest86plus}/memtest.efi";
    #   "efi/<dirName>/<efiBinaryName>.efi" = "${pkgs.<efiBinaryPackage>}/<efiBinaryName>.efi";
    #   "efi/reboot-bootloader/no-plymouth.efi" = "${pkgs.systemd-boot}/systemd-boot.efi";  # TODO: Get real path
    # };

    # TODO: Clover (hackintosh)
    # TODO: Entry: Ventoy?
    # extraEntries = {
    #  "efi-shell" = ''
    #    title EFI Shell
    #    efi
    #  '';
    #   "memtest86.conf" = ''
    #     title MemTest86+
    #     efi /etc/memtest86/memtest.efi
    #   '';
    #   "reboot-to-firmware-setup" = ''
    #     title UEFI Settings
    #     efi 
    #   '';
    #   "windows" = ''
    #     title Windows 11
    #     efi
    #   '';
    #   "usb-boot" = ''
    #     title Boot from USB drive
    #     efi
    #   '';
    #   # --- Launch Existing EFI Binaries ---
    #   # TODO: Add EFI binary paths for all extraEntries.
    #   "restart-bootloader" = ''
    #     title Restart Bootloader
    #     efi
    #   '';
    #   "restart-bootloader-no-splash" = ''
    #     title Restart Bootloader (without boot splash)
    #     efi
    #   '';
    #   "restart-bootloader-no-timeout" = ''
    #     title Restart Bootloader (without timeout)
    #     efi
    #   '';
    #   "restart-bootloader-enable-debug" = ''
    #     title Restart Bootloader (debugging enabled)
    #     efi
    #   '';
    # };
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
