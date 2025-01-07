{ inputs, config, lib, pkgs, ... }:
#
# https://wiki.archlinux.org/index.php/Disk_encryption
# https://nixos.wiki/wiki/Full_Disk_Encryption
# https://nixos.org/wiki/Encrypted_Root_on_NixOS
# https://nixos.wiki/wiki/Remote_disk_unlocking
#
let
  inherit (lib) mkDefault mkIf;
  opts = {
    disk-unlock-password-entry = true;
    disk-unlock-usb-key = false;
  };
in
{
  boot.initrd = {
    # --- Graphical Disk Unlock w/ Touch Keyboard ---
    # https://github.com/droidian/unl0kr
    # TODO: Enable when:
    # - no keyboard OR touchscreen (mobile devices)
    # - disk encrypted
    # TODO: Write configuration file.
    # TODO: Create NixOS module for config options.
    # TODO: Move config to profiles/mobile?
    unl0kr.enable = mkDefault opts.disk-unlock-password-entry;
    kernelModules = mkIf opts.disk-unlock-usb-key ["usb_storage"];
  };

  boot.loader = {
    # Second until default bootloader entry boots.
    # - `null` = wait indefinitely
    timeout = mkDefault 6;
    # [nix-community/srvos](https://github.com/nix-community/srvos/blob/main/nixos/mixins/systemd-boot.nix) recommend enable during install only

    efi = {
      # Where to mount the EFI system partition
      #  TODO: Follow Discoverable Partitions Spec: 
      #    https://uapi-group.org/specifications/specs/discoverable_partitions_specification/
      #    - TODO: `XBOOTLDR` / `ESP` splitting?
      #    - TODO: Rewrite to `/efi`, `/boot`, or `/boot/efi`?
      #  NOTE: Set to "/boot/efi" in `nixos/hosts/fw/configuration.nix`
      #  Default: "/boot"
      efiSysMountPoint = mkDefault "/boot"; #"/boot/efi";

      # Whether install process allowed to modify EFI boot variables
      canTouchEfiVariables = mkDefault true; 
    };
  };

}
