{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    config.flake.nixosProfiles.disko.base
    config.flake.diskoProfiles.tmpfs-root
    inputs.impermanence.nixosModules.impermanence
  ];
}
