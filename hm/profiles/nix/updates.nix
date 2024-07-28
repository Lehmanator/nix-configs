{ config, lib, pkgs, ... }:
{
  home.packages = [
    # Package to update nixpkgs packages
    pkgs.nixpkgs-update

    # Needed for interactive updates if not using GITHUB_TOKEN env var
    pkgs.hub 
  ];
    # let
    #   sources = ./sources.nix;
    #   nixpkgs-update = import sources.nixpkgs-update {};
    # in [nixpkgs-update];

  # --- Interactive Updates ---
  sops.secrets.github-token-nixpkgs-update = {};
  home.sessionVariables.GITHUB_TOKEN = config.sops.secrets.github-token-nixpkgs-update.path;

  # --- Batch Updates ---
  # https://nix-community.github.io/nixpkgs-update/batch-updates/#batch-updates

  # git clone https://github.com/ryantm/nixpkgs-update && cd nixpkgs-update && nix-build
  # ./result/bin/nixpkgs-update update "pkg oldVer newVer update-page"`

  # # Example:
  # ./result/bin/nixpkgs-update update "tflint 0.15.0 0.15.1 repology.org"`

  # # Get list of outdated packages & place them in file: `packages-to-update.txt`
  # ./result/bin/nixpkgs-update fetch-repology > packages-to-update.txt

  # ./result/bin/nixpkgs-update update-list
}
