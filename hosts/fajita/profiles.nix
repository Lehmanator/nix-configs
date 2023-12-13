{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    #../../profiles/adb.nix
    #../../profiles/desktop
    #../../profiles/desktop/de/gnome
    ../../profiles/mobile
    ../../profiles/nixos
    #../../profiles/virt/emulators/slippi.nix

    ../../profiles/desktop/flatpak.nix
    # --- Disabled ---
    #../../profiles/editor
    #../../profiles/hardware/fprintd.nix
    #../../profiles/virt/windows

    # --- Imported by profiles/nixos ---
    #../../profiles/boot
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
