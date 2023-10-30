{ self, inputs, config, lib, pkgs, ... }:
{
  imports = [];
  environment.systemPackages = [
    pkgs.cachix # CLI for cachix binary caches
    pkgs.deadnix # Find dead code in Nix configs
    pkgs.manix # Search documentation
    pkgs.nix-doc # Search docs & Generate tags + plugin
    pkgs.nix-plugins # Misc Nix plugins
    pkgs.nix-du # Show sizes of Nix store paths
    pkgs.nix-init # Generate packages from URLs
    pkgs.nix-output-monitor
    pkgs.nix-tree # Interactively view dep graphs of Nix derivations
    pkgs.nix-update # Update Nix packages
    #pkgs.nix-query-tree-viewer # GUI to view Nix store path deps
    pkgs.nurl # Automatically generate fetcher expressions from URLs
    #pkgs.nvfetcher # Update package commits & hashes
    pkgs.pre-commit # Git pre-commit hooks
    pkgs.vulnix # Nix(OS) vulnerability scanner
  ];
}
