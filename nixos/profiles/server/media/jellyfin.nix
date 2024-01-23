{ config, lib, pkgs, ... }:
{
  imports = [ ];
  services = {
    jellyfin = { enable = true; openFirewall = true; };
    jellyseerr.enable = true;
  };
}
