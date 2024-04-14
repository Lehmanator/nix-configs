{ inputs, ... }:
{
  # https://github.com/nix-community/nixvim
  imports = [ inputs.nixvim.nixDarwinModules.nixvim ];
  home-manager.sharedModules = [ inputs.nixvim.homemManagerModules.nixvim ];
  # TODO: Learn about `lib.extendModules`
}
