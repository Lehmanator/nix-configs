{ config, lib, pkgs, ... }:
{
  # Enable "Silent Boot"
  # - Note: Required for Plymouth bootsplash?
  boot = {
    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    loader.timeout = 0;

    # Lowest boot console log level
    consoleLogLevel = 0;

    # Minimal info to console in initrd
    initrd.verbose = false;

    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"

      # -- plymouth.nix ---
      # These params were previously enabled in ./plymouth.nix,
      # but weren't in wiki page on quiet boot / Plymouth, so we removed them.
      #
      #"systemd.show_status=auto"
      #"udev.log_level=3"
      #"vt.global_cursor_default=0"
    ];
  };
}
