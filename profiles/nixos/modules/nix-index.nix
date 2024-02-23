{ inputs
, lib
, ...
}:
# TODO: Move all config that isn't NixOS-specific stuff to common file
{
  imports = [
    inputs.nix-data.nixosModules.nix-data
    #inputs.nix-index.nixosModules.nix-index
    inputs.nix-index-database.nixosModules.nix-index
  ];

  programs = {
    command-not-found = lib.mkDefault false;
    nix-index-database.comma.enable = lib.mkDefault true;
  };

  home-manager.sharedModules = [
    inputs.nix-index-database.hmModules.nix-index
    # --- OR ---
    #../../../hm/profiles/modules/nix-index.nix
  ];
}
