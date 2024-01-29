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

  # TODO: Configure GNU ls

  # --- Directory Listing -----
  home.shellAliases = {
    l = lib.mkDefault "${program} -a";
    lt = lib.mkDefault "${program} --tree";
  };
}
