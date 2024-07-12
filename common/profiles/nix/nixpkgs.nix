{ inputs
, config
, lib
, pkgs
, ...
}:
{
  nixpkgs.config = {
    allowBroken = true;
    allowUnfree = true;
    allowUnsupportedSystem = true;

    packageOverrides = pkgs: {
      electron_24 = pkgs.electron_26; # Electron v24 is end-of-life, forcing upgrade
      electron_25 = pkgs.electron_26; # Electron v25 is end-of-life, forcing upgrade
    };
    permittedInsecurePackages = ["python3.12-youtube-dl-2021.12.17"];
  };

  #environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = lib.mkIf config.nixpkgs.config.allowUnfree "1" ;
}
