{ inputs, ... }: {
  # https://github.com/nix-community/nixvim
  imports = [ inputs.nixvim.nixosModules.nixvim ];

  # TODO: Default system config

  home-manager.sharedModules = [
    inputs.nixvim.homeManagerModules.nixvim
    #inputs.self.homeProfiles.nixvim
  ];

  # TODO: Learn about `lib.extendModules`
}
