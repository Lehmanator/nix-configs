{ self
, inputs
, overlays
, packages
, modules
, templates
, config
, lib
, pkgs
, ...
}:
{
  imports = [
  ];

  # Keep legacy nix-channels in sync w/ flake inputs (for tooling compat)
  # TODO: Same for NixOS, conditionally if system is NixOS
  xdg.configFile."nix/inputs/nixpkgs".source = inputs.nixpkgs.outPath;
  home.sessionVariables.NIX_PATH = "nixpkgs=${config.xdg.configHome}/nix/inputs/nixpkgs$\{NIX_PATH:+:$NIX_PATH}";

  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  #nix.settings.plugin-files = [
  #  "${pkgs.nix-doc}/lib/libnix_doc_plugin.so"
  #  "${pkgs.nix-plugins}/lib/nix/plugins/libnix-extra-builtins.so"
  #];

  home.packages = [
    # --- Documentation ------
    pkgs.manix # Nix documentation CLI
    pkgs.nix-doc # Nix documentation CLI

    # --- Package Updaters ---
    pkgs.nix-init # Automatically create Nix package definitions from git repos
    pkgs.nix-update # Updates versions/source/hashes of Nix packages to latest
    #pkgs.nixpkgs-update
    pkgs.nurl # Automatically generate fetcher expressions from URLs
    pkgs.nvfetcher # Update Nix resource commits & hashes

    # --- Nix Plugins --------
    pkgs.nix-plugins # Extensions for Nix
  ];
}
