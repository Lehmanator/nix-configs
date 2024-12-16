{ config, lib, pkgs, ... }:
{
  imports = [
    ./yaml.nix
  ];
  
  home.packages = [
    pkgs.docker-compose
    pkgs.docker-compose-language-service
    pkgs.dockerfile-language-server-nodejs
  ];
  programs.helix.extraPackages = [
    pkgs.docker-compose
    pkgs.docker-compose-language-service
  ];
  programs.zed-editor.extensions = ["dockerfile" "docker-compose"];
}
