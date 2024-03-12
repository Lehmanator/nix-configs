{ inputs, config, lib, pkgs, ... }: {
  imports = [ ];

  commands = [ ];
  env = [ ];

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
