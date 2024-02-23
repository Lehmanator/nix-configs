{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
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
    ../../profiles/nixos/security
    ../../profiles/nixos/security/apparmor.nix
    #../../profiles/nixos/server/kubernetes/k3s-node-main.nix
    #../../profiles/nixos/users/homed.nix
    ../../profiles/nixos/virt
    #../../profiles/nixos/virt/emulators/slippi.nix
    ../../profiles/nixos/cachix-agent.nix
    ../../profiles/nixos/hercules-ci.nix

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
