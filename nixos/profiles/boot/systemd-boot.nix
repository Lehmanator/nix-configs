{ inputs, config, lib, pkgs, ... }: {
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
  };
}
