{ inputs
, config
, lib
, pkgs
, user
, ...
}:
{
  imports = [ inputs.nur.nixosModules.nur ];

  home-manager.sharedModules = [
    inputs.nur.hmModules.nur
    # --- OR ---
    #../../../hm/profiles/nur.nix
  ];
}
