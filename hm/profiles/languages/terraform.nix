{ config, lib, pkgs, ... }:
{
  home.packages = [
    pkgs.terraform-lsp
  ];
  programs.helix.extraPackages = [
    pkgs.terraform-lsp
  ];
}
