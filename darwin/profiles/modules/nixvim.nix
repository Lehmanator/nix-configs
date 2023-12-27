{ inputs, config, lib, pkgs, user, ... }:
{
  # https://github.com/nix-community/nixvim
  imports = [ inputs.nixvim.nixDarwinModules.nixvim ];

  # TODO: Default system config

  home-manager.sharedModules = [
    inputs.nixvim.homemManagerModules.nixvim
    # --- OR ---
    #../../../hm/profiles/modules/nixvim.nix
  ];

  # TODO: Learn about `lib.extendModules`

}
