{ inputs, lib, config, pkgs, user, ... }:
{
  imports = [
    ./editor
    ./nix
    ./shell
  ];
}
