{ config, lib, pkgs, ... }:
{
  home.packages = [
    pkgs.nodejs
    pkgs.node2nix         # Convert npm packages to Nix
    pkgs.nodePackages_latest.npm-check-updates
    pkgs.zsh-better-npm-completion
    pkgs.prefetch-npm-deps
    pkgs.prefetch-yarn-deps
    pkgs.yarn
    pkgs.yarn2nix
    pkgs.yarn-bash-completion
  ];
}
