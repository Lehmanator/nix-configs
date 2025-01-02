{ inputs, config, lib, pkgs, user, ... }:
{
  # TODO: Default system config
  # https://github.com/nix-community/nixvim
  imports = [ inputs.nixvim.nixosModules.nixvim ];
  home-manager.sharedModules = [ inputs.nixvim.homeManagerModules.nixvim ];
}
