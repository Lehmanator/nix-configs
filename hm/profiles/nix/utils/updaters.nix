{ inputs, pkgs, ... }: {
  home.packages = [
    pkgs.niv # Nix project dependency management
    pkgs.nix-init # Auto create Nix package definitions from git repos
    pkgs.nix-update # Update Nix package version/source/hash to latest
    pkgs.nurl # Auto generate fetcher expressions from URLs
    pkgs.nvfetcher # Update Nix resource commits & hashes
    pkgs.pr-tracker # Nixpkgs pull request channel tracker
    #pkgs.nixpkgs-update
    pkgs.update-nix-fetchgit

    inputs.fast-flake-update.packages.${pkgs.system}.default
  ];
}
