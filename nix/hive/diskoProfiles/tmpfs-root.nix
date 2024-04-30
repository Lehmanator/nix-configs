{ config, lib, pkgs, ... }:
let
  # TODO: Determine size.default from RAM.
  size = {
    min = "200M";
    max = "32G";
    default = "2G";
  };
in
{
  disko.devices.nodev."/" = {
    fsType = "tmpfs";
    mountOptions = ["size=${size.default}" "defaults" "mode=755"];
  };
}
