{ config, lib, pkgs, ... }:
{
  programs.git.aliases.cog = "${lib.getExe pkgs.cocogitto} commit";
  home.packages = [
    pkgs.cocogitto
    pkgs.pre-commit
    
    # https://github.com/yuvipanda/pre-commit-hook-ensure-sops
    pkgs.pre-commit-hook-ensure-sops

    pkgs.git-cliff
  ];
}
