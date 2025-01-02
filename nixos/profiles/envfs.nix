{ inputs, config, lib, pkgs, ... }:
{
  imports = [inputs.envfs.nixosModules.envfs];
  home-manager.sharedModules = [];

  services.envfs.enable = lib.mkDefault true;
}
