{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [ ];

  boot.loader.systemd-boot = {
    extraEntries = {
      # --- Launch Existing EFI Binaries ---
      # TODO: Add EFI binary paths for all extraEntries.
      "restart-bootloader" = ''
        title Restart Bootloader
        efi
      '';
      "restart-bootloader-no-splash" = ''
        title Restart Bootloader (without boot splash)
        efi
      '';
      "restart-bootloader-no-timeout" = ''
        title Restart Bootloader (without timeout)
        efi
      '';
      "restart-bootloader-enable-debug" = ''
        title Restart Bootloader (debugging enabled)
        efi
      '';
    };

    extraFiles = {
      #"efi/<dirName>/<efiBinaryName>.efi" = "${pkgs.<efiBinaryPackage>}/<efiBinaryName>.efi";
      #"efi/reboot-bootloader/no-plymouth.efi" = "${pkgs.systemd-boot}/systemd-boot.efi";  # TODO: Get real path
    };

  };

}
