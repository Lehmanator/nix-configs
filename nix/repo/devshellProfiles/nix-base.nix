{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  # See also:
  # - [Work on dotfiles w/o huge Nix build overhead](https://nixos-and-flakes.thiscute.world/best-practices/accelerating-dotfiles-debugging)
  #   - [More Justfile NixOS stuff](https://nixos-and-flakes.thiscute.world/best-practices/simplify-nixos-related-commands)
  #   - [ryan4yin/nix-config/Justfile](https://github.com/ryan4yin/nix-config/blob/main/Justfile)

  imports = [];

  commands = [];
  env = [];

  packages = [
    pkgs.cachix

    # --- Builders ---
    pkgs.nix-output-monitor # Pretty build output
    inputs.nix-fast-build.packages.${pkgs.system}.nix-fast-build

    # --- Documentation ---
    pkgs.nix-doc # Search docs & generate tags + plugin
    pkgs.manix
    pkgs.vimPlugins.telescope-manix

    # --- Linters ---
    pkgs.alejandra
    pkgs.deadnix
    pkgs.vulnix

    # --- Package Generators ---
    pkgs.nix-init # Generate packages from URLs

    # --- Plugins ---
    pkgs.nix-plugins

    # --- Nix Store ---
    pkgs.nix-du # Show sizes of Nix store paths
    pkgs.nix-tree # Interactively view dep graphs of Nix derivations

    # --- Updaters ---
    pkgs.nix-update # Update Nix packages
    pkgs.nurl # Auto-gen fetcher expressions from URLs
    pkgs.nvfetcher # Update package commits/hashes
  ];
}
