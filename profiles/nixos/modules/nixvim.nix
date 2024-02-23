{inputs, ...}: {
  # https://github.com/nix-community/nixvim
  imports = [inputs.nixvim.nixosModules.nixvim];

  # TODO: Default system config

  home-manager.sharedModules = [
    inputs.nixvim.homeManagerModules.nixvim
    # --- OR ---
    #../../../hm/profiles/modules/nixvim.nix
  ];

  # TODO: Learn about `lib.extendModules`
}
