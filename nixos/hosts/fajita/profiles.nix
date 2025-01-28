{inputs, ...}: {
  imports = [
    (inputs.self + /nixos/profiles)
    (inputs.self + /nixos/profiles/flatpak.nix)
    (inputs.self + /nixos/profiles/mobile.nix)
    (inputs.self + /nixos/profiles/slippi.nix)

    # (inputs.self + /nixos/profiles/desktop)
    # (inputs.self + /nixos/profiles/gnome)

    # --- Disabled ---
    # (inputs.self + /nixos/profiles/fprintd.nix)
    # (inputs.self + /nixos/profiles/vm-guest-windows.nix)
    # (inputs.self + /common/profiles/editor)

    # --- Imported by profiles/nixos ---
    # (inputs.self + /nixos/profiles/bash.nix)
    # (inputs.self + /nixos/profiles/boot)
    # (inputs.self + /nixos/profiles/hardware)
    # (inputs.self + /nixos/profiles/locale-est.nix)
    # (inputs.self + /nixos/profiles/network)
    # (inputs.self + /nixos/profiles/sudo.nix)
    # (inputs.self + /nixos/profiles/sops.nix)
    # (inputs.self + /nixos/profiles/user-primary.nix)
    # (inputs.self + /nixos/profiles/zsh.nix)
  ];
}
