{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = with inputs; [
    ../../profiles/nixos
    ../../profiles/nixos/boot
    ../../profiles/nixos/desktop
    ../../profiles/nixos/desktop/de/gnome
    ../../profiles/nixos/hardware/display
    ../../profiles/nixos/hardware/tpm2.nix
    ../../profiles/nixos/hardware/peripherals/apple.nix
    ../../profiles/nixos/hardware/peripherals/logitech.nix
    #../../profiles/nixos/hardware/peripherals/printers.nix
    #../../profiles/nixos/hardware/peripherals/scanners.nix
    ../../profiles/nixos/network/tailscale/mullvad.nix
    ../../profiles/nixos/security
    #../../profiles/nixos/server/kubernetes/k3s-node-main.nix
    ../../profiles/nixos/virt
    #../../profiles/nixos/virt/emulators/slippi.nix
    self.nixosModules.apparmor
    self.nixosModules.cachix-agent
    self.nixosModules.hercules-ci
    #self.nixosModules.homed

    # --- Disabled ---
    #../../profiles/nixos/hardware/fprintd.nix
    #../../profiles/nixos/virt/windows
    #../../profiles/common/editor

    # --- Imported by profiles/nixos ---
    #../../profiles/nixos/nixos
    #../../profiles/nixos/hardware
    #../../profiles/nixos/locale
    #../../profiles/nixos/network
    #../../profiles/nixos/piwc
    #../../profiles/nixos/security
    #../../profiles/nixos/security/sops.nix
    #../../profiles/nixos/shell
    #../../profiles/nixos/users
  ];
}
