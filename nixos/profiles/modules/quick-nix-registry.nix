{ inputs
, config
, lib
, pkgs
, user
, ...
}:
{
  imports = [ inputs.quick-nix-registry.nixosModules.local-registry ];
  nix.localRegistry = {
    enable = lib.mkDefault true;
    cacheGlobalRegistry = lib.mkDefault true;
    noGlobalRegistry = lib.mkDefault false;
  };
}
