{ config, lib, pkgs, ... }:
{
  nix.settings.extra-experimental-features = [ "impure-derivations" "configurable-impure-env" ];
}
