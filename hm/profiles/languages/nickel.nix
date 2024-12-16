{ config, lib, pkgs, ... }:
{
  home.packages = [
    pkgs.nickel
    pkgs.nls
  ];
  programs.helix.extraPackages = [
    pkgs.nickel
    pkgs.nls
  ];
  programs.zed-editor = {
    # extraPackages = [pkgs.nickel pkgs.nls];
    extensions = ["nickel"];
  };
}
