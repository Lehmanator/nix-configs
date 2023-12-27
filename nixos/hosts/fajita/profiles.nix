{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    ../../profiles
    ../../profiles/desktop/flatpak.nix
    ../../profiles/mobile

    #../../profiles/desktop
    #../../profiles/desktop/de/gnome
    #../../profiles/virt/emulators/slippi.nix

    # --- Disabled ---
    #../../profiles/hardware/fprintd.nix
    #../../profiles/virt/windows
    #../../../common/profiles/editor

    # --- Imported by profiles/nixos ---
    #../../profiles/boot
    #../../profiles/hardware
    #../../profiles/locale
    #../../profiles/network
    #../../profiles/security
    #../../profiles/security/sops.nix
    #../../profiles/shell
    #../../profiles/users
  ];
}
