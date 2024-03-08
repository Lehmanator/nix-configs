{ config, lib, pkgs, inputs, ... }: {
  imports = [
    inputs.self.nixosProfiles.flatpak
    inputs.self.nixosProfiles.locale-est.nix
    inputs.self.nixosProfiles.sops
    ../../profiles/nixos
    ../../profiles/nixos/mobile
    ../../profiles/nixos/network/tailscale/mullvad.nix
    # --- Disabled ---
    #../../profiles/nixos/boot.nix
    #../../profiles/nixos/security.nix
    #../../profiles/nixos/hardware/fprintd.nix
    #../../profiles/nixos/virt/windows
    #../../profiles/common:editor
    # --- Imported by profiles/nixos ---
    #../../profiles/nixos/hardware
    #../../profiles/nixos/network
    #../../profiles/nixos/shell
    #../../profiles/nixos/users
  ];
}
