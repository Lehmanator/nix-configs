{ config, lib, pkgs, inputs, ... }: {
  imports = [
    (inputs.self + /nixos/profiles)
    (inputs.self + /nixos/profiles/apparmor.nix)
    (inputs.self + /nixos/profiles/boot)
    (inputs.self + /nixos/profiles/cachix-agent.nix)
    (inputs.self + /nixos/profiles/desktop)
    (inputs.self + /nixos/profiles/desktop/gnome)
    (inputs.self + /nixos/profiles/disko.nix)
    (inputs.self + /nixos/profiles/hardware/display)
    (inputs.self + /nixos/profiles/hardware/tpm2.nix)
    (inputs.self + /nixos/profiles/hardware/peripherals/apple.nix)
    (inputs.self + /nixos/profiles/hardware/peripherals/logitech.nix)
    (inputs.self + /nixos/profiles/lanzaboote.nix)
    (inputs.self + /nixos/profiles/security)
    (inputs.self + /nixos/profiles/virt)
    # (inputs.self + /nixos/profiles/hercules-ci.nix)
    # (inputs.self + /nixos/profiles/slippi.nix)
    # (inputs.self + /nixos/profiles/hardware/peripherals/printers.nix)
    # (inputs.self + /nixos/profiles/hardware/peripherals/scanners.nix)
    # (inputs.self + /nixos/profiles/server/kubernetes/k3s-node-main.nix)
    # (inputs.self + /nixos/profiles/users/homed.nix)

    # --- Disabled ---
    # (inputs.self + /nixos/profiles/virt/windows)
    # (inputs.self + /common/profiles/editor)

    # --- Imported by profiles/nixos ---
    # (inputs.self + /nixos/profiles/nixos)
    # (inputs.self + /nixos/profiles/hardware)
    # (inputs.self + /nixos/profiles/locale)
    # (inputs.self + /nixos/profiles/network)
    # (inputs.self + /nixos/profiles/security)
    # (inputs.self + /nixos/profiles/security/sops.nix)
    # (inputs.self + /nixos/profiles/shell)
    # (inputs.self + /nixos/profiles/users)
  ];
}
