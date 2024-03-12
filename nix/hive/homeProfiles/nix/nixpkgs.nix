{
  config,
  lib,
  pkgs,
  ...
}: {
  nixpkgs.config = {
    allowBroken = true;
    allowUnfree = true;
    allowUnsupportedSystem = true;

    packageOverrides = pkgs: {
      electron_24 =
        pkgs.electron_26; # Electron v24 is end-of-life, forcing upgrade
      electron_25 =
        pkgs.electron_26; # Electron v25 is end-of-life, forcing upgrade
    };
  };

  #environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = lib.mkIf config.nixpkgs.config.allowUnfree "1" ;
}
