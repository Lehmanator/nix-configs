{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  program = "eza";
in {
  imports = [./eza.nix ./lsd.nix ./pls.nix];

  # --- Directory Listing -----
  home.shellAliases = {
    l = lib.mkDefault "${program} -a";
    lt = lib.mkDefault "${program} --tree";
  };
}
