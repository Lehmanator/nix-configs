{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../../profiles/nixos
    ../../profiles/nixos/desktop/flatpak.nix
    ../../profiles/nixos/mobile
    #../../profiles/nixos/desktop
    #../../profiles/nixos/desktop/de/gnome
    #../../profiles/nixos/virt/emulators/slippi.nix
    # --- Disabled ---
    #../../profiles/nixos/hardware/fprintd.nix
    #../../profiles/nixos/virt/windows
    #../../profiles/common:editor
    # --- Imported by profiles/nixos ---
    #../../profiles/nixos/boot
    #../../profiles/nixos/hardware
    #../../profiles/nixos/locale
    #../../profiles/nixos/network
    #../../profiles/nixos/security
    #../../profiles/nixos/security/sops.nix
    #../../profiles/nixos/shell
    #../../profiles/nixos/users
  ];
}
