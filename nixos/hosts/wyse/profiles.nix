{ modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../../profiles

    ../../profiles/boot
    ../../profiles/desktop
    ../../profiles/desktop/de/gnome
    ../../profiles/hardware/display
    ../../profiles/hardware/fwupd.nix
    ../../profiles/hardware/peripherals/logitech.nix
    ../../profiles/hardware/usb.nix
    ../../profiles/security/apparmor.nix
    #../../profiles/server/kubernetes/k3s-node-main.nix
    ../../profiles/users/homed.nix
    ../../profiles/virt
    ../../profiles/virt/emulators/slippi.nix

    #../../profiles/hardware/display/displaylink.nix
    #../../profiles/hardware/tpm1.2.nix
    #../../profiles/virt/windows
    #../../../common/profiles/editor
  ];
}
