{ config, lib, pkgs, ... }:
{
  home.packages = [
    pkgs.yaml-language-server
  ];
  programs.helix.extraPackages = [
    pkgs.yaml-language-server
  ];
  # programs.zed-editor.extraPackages = [
  #   pkgs.yaml-language-server
  # ];
}
