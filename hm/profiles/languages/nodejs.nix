{ config, lib, pkgs, ... }:
{
  imports = [
    ./javascript.nix
    ./json.nix
  ];
  home.packages = [
    pkgs.nodejs
    pkgs.node2nix         # Convert npm packages to Nix
    pkgs.nodePackages_latest.npm-check-updates
    pkgs.prefetch-npm-deps
    pkgs.prefetch-yarn-deps
    pkgs.yarn
    pkgs.yarn2nix
    pkgs.yarn-bash-completion
    pkgs.zsh-better-npm-completion
  ];

  programs.helix.extraPackages = [
    pkgs.dockerfile-language-server-nodejs
    pkgs.svelte-language-server
    pkgs.tailwindcss-language-server
    pkgs.vue-language-server
  ];
  programs.zed-editor.extensions = ["svelte" "vue"];

}
