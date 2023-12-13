{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    ../../profiles/adb.nix
    ../../profiles/desktop
    ../../profiles/desktop/de/gnome
    ../../profiles/hardware/display
    ../../profiles/hardware/tpm2.nix
    ../../profiles/hardware/peripherals/logitech.nix
    ../../profiles/nixos
    ../../profiles/nixos/boot
    ../../profiles/nixos/homed.nix
    ../../profiles/piwc
    ../../profiles/security
    ../../profiles/security/apparmor.nix
    ../../profiles/server/kubernetes/k3s-node-main.nix
    ../../profiles/virt
    ../../profiles/virt/emulators/slippi.nix

    # --- Disabled ---
    #../../profiles/editor
    #../../profiles/hardware/fprintd.nix
    #../../profiles/virt/windows

    # --- Imported by profiles/nixos ---
    #../../profiles/hardware
    #../../profiles/locale
    #../../profiles/network
    #../../profiles/security
    #../../profiles/security/sops.nix
    #../../profiles/shell
    #../../profiles/sshd.nix
    #../../profiles/users
  ];
}
