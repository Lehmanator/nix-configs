{ inputs, lib, pkgs, config, osConfig, ... }:
{
  home.packages = [
    pkgs.nix-doc # Nix documentation CLI

    # --- Diffs ---
    pkgs.nvd  # Nix version diff tool
    pkgs.niff # Compares two Nix expressions & determines what attributes changed
  ];
}
