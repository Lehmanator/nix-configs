{ inputs
, config
, lib
, pkgs
, ...
}:
{
  nixpkgs.config = {
    allowBroken = false;
    allowUnfree = true;

    packageOverrides = pkgs: {
      electron_24 = pkgs.electron_25; # Electron v24 is end-of-life, forcing upgrade
    };
  };

  #environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = lib.mkIf config.nixpkgs.config.allowUnfree "1" ;
}
