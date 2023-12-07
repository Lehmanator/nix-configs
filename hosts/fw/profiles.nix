{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    ../../profiles/adb.nix
    ../../profiles/boot
    ../../profiles/desktop
    ../../profiles/desktop/de/gnome
    #../../profiles/editor
    ../../profiles/hardware/display
    #../../profiles/hardware/fprintd.nix
    ../../profiles/hardware/fwupd.nix
    ../../profiles/hardware/peripherals/logitech.nix
    ../../profiles/hardware/tpm2.nix
    ../../profiles/hardware/usb.nix
    ../../profiles/locale
    ../../profiles/network
    ../../profiles/nixos
    ../../profiles/piwc
    ../../profiles/security/polkit.nix
    ../../profiles/security/sops.nix
    ../../profiles/server/kubernetes/k3s-node-main.nix
    ../../profiles/shell
    ../../profiles/sshd.nix
    ../../profiles/users
    ../../profiles/virt
    #../../profiles/virt/windows
  ];
}
