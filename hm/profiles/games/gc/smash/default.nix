{ inputs, config, lib, pkgs, ... }:
{
  imports = [
    #./iso.nix
    ./slippi.nix
    #./20xx.nix
    #./unclepunch.nix
    #./universal-controller-fix.nix
  ];
}
