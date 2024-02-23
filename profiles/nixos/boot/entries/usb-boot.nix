{ config, ... }:
{
  imports = [ ];

  # TODO: Enable networking, disks in initrd / UEFI?

  boot.loader.systemd-boot = {
    extraEntries = {
      # TODO: Add EFI binary paths for all extraEntries.
      "usb-boot" = ''
        title Boot from USB drive
        efi
      '';
    };

    extraFiles = {
      #"efi/<dirName>/<efiBinaryName>.efi" = "${pkgs.<efiBinaryPackage>}/<efiBinaryName>.efi";
      #"efi/reboot-bootloader/no-plymouth.efi" = "${pkgs.systemd-boot}/systemd-boot.efi";  # TODO: Get real path
    };
  };
}
