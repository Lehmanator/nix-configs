{ config, lib, pkgs, ... }:
{
  services.fwupd = {
    enable = true;
    extraRemotes = [ "lvfs-testing" ];

    # Might be necessary once to make the update succeed
    # uefiCapsuleSettings.DisableCapsuleUpdateOnDisk = true;
  };

  # boot.loader.systemd-boot.extraEntries.fwupd = ''
  #   # TODO: Add EFI binary paths for all extraEntries
  #   title Firmware Updater
  #   efi
  # '';
  # boot.loader.systemd-boot.extraFiles = {
  #   "efi/<dirName>/<efiBinaryName>.efi" = "${pkgs.<efiBinaryPackage>}/<efiBinaryName>.efi";
  #   "efi/reboot-bootloader/no-plymouth.efi" = "${pkgs.systemd-boot}/systemd-boot.efi";  # TODO: Get real path
  # };

}
