{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [config.nixosProfiles.disko.base];
  disko.enableConfig = lib.mkImageMediaOverride false;
}
