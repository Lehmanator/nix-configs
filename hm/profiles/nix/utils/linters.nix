{ config, lib, pkgs, ... }:
{
  home.packages = [
    pkgs.alejandra # Nix linter
    pkgs.deadnix # Find dead code in Nix configs
    pkgs.vulnix # Nix(OS) vulnerability scanner
    #pkgs.rnix
  ];
}
