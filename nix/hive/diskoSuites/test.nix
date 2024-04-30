{
  inputs,
  cell,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [cell.diskoProfiles.btrfs-luks.nix cell.diskoProfiles.tmpfs-root];
}
