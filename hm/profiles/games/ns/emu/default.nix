{ inputs, config, lib, pkgs, ... }:
{
  imports = [
    ./ryujinx.nix
    ./yuzu.nix
  ];
}
