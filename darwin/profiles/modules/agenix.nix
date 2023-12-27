{ inputs, config, lib, pkgs, user, ... }:
{
  imports = [ inputs.agenix.darwinModules.age ];
  age = {
    ageBin = lib.mkDefault "${pkgs.age}/bin/age";
    identityPaths = lib.mkDefault [
    ];
    secretsDir = lib.mkDefault "/run/agenix";
    secretsMountPoint = lib.mkDefault "/run/agenix.d";
  };

  home-manager.sharedModules = [
    inputs.agenix.homeManagerModules.age
    # --- OR ---
    #../../../hm/profiles/modules/agenix.nix
  ];

}
