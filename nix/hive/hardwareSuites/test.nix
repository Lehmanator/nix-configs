{
  inputs,
  cell,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [cell.hardwareProfiles.disk-nvme];
}
