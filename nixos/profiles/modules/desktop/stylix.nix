{ inputs
, config
, lib
, pkgs
, user
, ...
}:
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  stylix = {
    homeManagerIntegration = lib.mkDefault true;
    autoImport = lib.mkDefault true;
  };
}
