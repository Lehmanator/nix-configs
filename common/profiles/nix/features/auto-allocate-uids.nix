{ config, lib, pkgs, ... }:
{
  nix.settings = {
    auto-allocate-uids = true;
    experimental-features = [ "auto-allocate-uids" ];
  };
}
