{ config, lib, pkgs, ... }:
{
  imports = [./docker.nix ./yaml.nix];
  home.packages = [
    pkgs.k9s
    pkgs.helm
    pkgs.helmfile
    pkgs.vals
  ];

  programs.helix.extraPackages = [];
  programs.zed-editor.extensions = ["helm"];
}
