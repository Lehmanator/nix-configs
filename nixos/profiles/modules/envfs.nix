{ inputs
, config
, lib
, pkgs
, user
, ...
}:
{
  imports = [ inputs.envfs.nixosModules.envfs ];
  services.envfs.enable = true;
}
