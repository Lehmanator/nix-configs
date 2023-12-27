{ modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../../profiles

    ../../profiles/desktop
    ../../profiles/desktop/de/gnome
    ../../profiles/hardware/fwupd.nix
    ../../profiles/hardware/peripherals/logitech.nix
    ../../profiles/hardware/usb.nix
    ../../profiles/locale
    ../../profiles/network
    ../../profiles/boot
    ../../profiles/security/polkit.nix
    ../../profiles/security/sops.nix
    ../../profiles/shell
    ../../profiles/users
    ../../profiles/virt

    #../../profiles/hardware/display/displaylink.nix
    #../../profiles/hardware/tpm1.2.nix
    #../../profiles/virt/windows
    #../../../common/profiles/editor
  ];
}
