{ modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../../profiles/desktop
    ../../profiles/desktop/de/gnome
    #../../profiles/editor
    #../../profiles/hardware/display/displaylink.nix
    ../../profiles/hardware/fwupd.nix
    ../../profiles/hardware/peripherals/logitech.nix
    #../../profiles/hardware/tpm1.2.nix
    ../../profiles/hardware/usb.nix
    ../../profiles/locale
    ../../profiles/network
    ../../profiles/nixos
    ../../profiles/nixos/boot
    ../../profiles/security/polkit.nix
    ../../profiles/security/sops.nix
    ../../profiles/shell
    ../../profiles/sshd.nix
    ../../profiles/users
    ../../profiles/virt
    #../../profiles/virt/windows
  ];

}
