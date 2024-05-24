{
  inputs,
  cell,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [cell.devshellProfiles.benchmarking cell.devshellProfiles.normalize];
}
