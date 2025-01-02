{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    "${inputs.self}/nixos/profiles"
    "${inputs.self}/nixos/profiles/flatpak.nix"
    "${inputs.self}/nixos/profiles/mobile"
    (inputs.self + /nixos/profiles/slippi.nix)

    #../../profiles/desktop
    #../../profiles/desktop/gnome

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
