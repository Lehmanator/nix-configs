{ config, lib, pkgs, ... }:
{
  nix.settings.experimental-features = [ "cgroups" ];
}
