{ config, lib, pkgs, ... }:
let
  cachix = lib.getExe pkgs.cachix;
in
{
  home = {

    # See: https://docs.cachix.org/pushing#pushing-flake-inputs
    shellAliases = {

      # Push entire nix-store to cache specified by arg: $1
      cachix-push-store = "nix path-info --all | ${cachix} push";
    };

    packages = [pkgs.cachix];
  };

}
