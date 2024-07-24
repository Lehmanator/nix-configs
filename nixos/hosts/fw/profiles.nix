{ config, lib, pkgs, inputs, ... }: {
  imports = [
    ../../profiles
    ../../profiles/boot
    ../../profiles/desktop
    ../../profiles/desktop/de/gnome
    ../../profiles/hardware/display
    ../../profiles/hardware/tpm2.nix
    ../../profiles/hardware/peripherals/apple.nix
    ../../profiles/hardware/peripherals/logitech.nix
    #../../profiles/hardware/peripherals/printers.nix
    #../../profiles/hardware/peripherals/scanners.nix
    ../../profiles/security
    ../../profiles/security/apparmor.nix
    #../../profiles/server/kubernetes/k3s-node-main.nix
    #../../profiles/users/homed.nix
    ../../profiles/virt
    #../../profiles/virt/emulators/slippi.nix
    ../../profiles/cachix-agent.nix
    ../../profiles/hercules-ci.nix

    # --- Disabled ---
    #../../profiles/hardware/fprintd.nix
    #../../profiles/virt/windows
    #../../../common/profiles/editor

    # --- Imported by profiles/nixos ---
    #../../profiles/nixos
    #../../profiles/hardware
    #../../profiles/locale
    #../../profiles/network
    #../../profiles/piwc
    #../../profiles/security
    #../../profiles/security/sops.nix
    #../../profiles/shell
    #../../profiles/users
  ];
}
