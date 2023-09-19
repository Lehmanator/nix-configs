{ inputs, self
, config, lib, pkgs
, user
#, netboot ? false
#, memtest ? false
#, harden ? true
, ...
}:
{
  imports = [
  ];

  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 100;  # Max generations in boot menu. Prevent boot partition from running out of space
    consoleMode = "keep";      # keep (keep mode selected by firmware) | max (pick highest-numbered available mode) | auto (auto-pick using heuristics) | "2" (1st non-standard mode provided by firmware if any) | "1" (80x50) | "0" (UEFI 80x25)
    #editor = !harden;          # Allow editing bootloader entries. Recommended to disable. Default=true for compat. Hardening: disable
    editor = false;          # Allow editing bootloader entries. Recommended to disable. Default=true for compat. Hardening: disable
    graceful = false;          # Invoke bootctl install with the --graceful option, which ignores errors when EFI variables cannot be written or when the EFI System Partition cannot be found.
                               # Currently only applies to random seed operations.
                               # Only enable this option if systemd-boot otherwise fails to install, as the scope or implication of the --graceful option may change in the future.

    # --- EFI Binaries ---
    #memtest86 = {
    #  enable = memtest;   # Memory testing util.
    #  entryFilename = "X-memtest86.conf";   # systemd-boot orders menu entries by config filenames. So make sure alphabetically after `nixos` if you want normal boot as first option.
    #};
    #netbootxyz = {
    #  enable = netboot;
    #  entryFilename = "X-netbootxyz.conf";  # See above ^^ (memtest86)
    #};

    # --- Extras ---
    #extraEntries = {
    #  "memtest86.conf" = ''
    #    title MemTest86+
    #    efi /etc/memtest86/memtest.efi
    #  '';
    #};

    #extraFiles = {
    #  "efi/memtest86/memtest.efi" = "${pkgs.memtest86plus}/memtest.efi";
    #};

    # Additional shell commands inserted in the bootloader installer script after generating menu entries.
    #  It can be used to expand on extra boot entries that cannot incorporate certain pieces of information (such as the resulting init= kernel parameter).
    #extraInstallCommands = ''
    #  default_cfg=$(cat /boot/loader/loader.conf | grep default | awk '{print $2}')
    #  init_value=$(cat /boot/loader/entries/$default_cfg | grep init= | awk '{print $2}')
    #  sed -i "s|@INIT@|$init_value|g" /boot/custom/config_with_placeholder.conf
    #'';




  };

  boot.loader.efi = {
    canTouchEfiVariables = lib.mkDefault true;
    #efiSysMountPoint = lib.mkDefault "/boot/efi";
  };

}
