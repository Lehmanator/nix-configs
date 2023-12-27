{ inputs, config, lib, pkgs, ... }:
{
  imports = [
    ./cachix.nix
    ./linters.nix
    ./manix.nix
    ./updaters.nix
  ];

  environment.systemPackages = [
    pkgs.nix-doc # Search docs & Generate tags + plugin
    pkgs.nix-plugins # Misc Nix plugins
    pkgs.nix-du # Show sizes of Nix store paths
    pkgs.nix-init # Generate packages from URLs
    pkgs.nix-output-monitor
    pkgs.nix-tree # Interactively view dep graphs of Nix derivations
    pkgs.nix-query-tree-viewer # GUI to view Nix store path deps
    pkgs.pre-commit # Git pre-commit hooks
    inputs.nix-fast-build.packages.${pkgs.system}.nix-fast-build
  ];
}
