{ config, lib, pkgs, inputs, ... }: {
  imports = with inputs; [
    self.nixosProfiles.apparmor
    self.nixosProfiles.cachix-agent
    self.nixosProfiles.desktop
    self.nixosProfiles.gnome
    self.nixosProfiles.hercules-ci
    self.nixosProfiles.locale-est.nix
    #self.nixosProfiles.homed
    #self.nixosProfiles.sops
    #self.nixosProfiles.user-primary
    ../../profiles/nixos
    ../../profiles/nixos/boot.nix
    ../../profiles/nixos/hardware/display
    ../../profiles/nixos/hardware/tpm2.nix
    ../../profiles/nixos/hardware/peripherals/apple.nix
    ../../profiles/nixos/hardware/peripherals/logitech.nix
    ../../profiles/nixos/network/tailscale/mullvad.nix
    ../../profiles/nixos/security.nix
    ../../profiles/nixos/virt.nix
    #../../profiles/nixos/hardware/peripherals/printers.nix
    #../../profiles/nixos/hardware/peripherals/scanners.nix
    #../../profiles/nixos/server/kubernetes/k3s-node-main.nix
    #../../profiles/nixos/virt/emulators/slippi.nix

    # --- Disabled ---
    #../../profiles/nixos/hardware/fprintd.nix
    #../../profiles/common/editor

    # --- Imported by profiles/nixos ---
    #../../profiles/nixos/hardware
    #../../profiles/nixos/network
    #../../profiles/nixos/piwc
    #../../profiles/nixos/shell
  ];
}
