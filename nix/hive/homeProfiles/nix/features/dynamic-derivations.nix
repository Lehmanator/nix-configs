{ pkgs, ... }:
{
  nix.settings.extra-experimental-features = [ "dynamic-derivations" ];
}
