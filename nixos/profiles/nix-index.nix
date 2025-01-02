{ inputs, config, lib, pkgs, ... }:
{
  # TODO: Move all config that isn't NixOS-specific stuff to common file
  # nix-index.nixosModules.nix-index
  # nix-data.nixosModules.nix-data
  imports = [inputs.nix-index-database.nixosModules.nix-index];

  home-manager.sharedModules = [(inputs.self + /hm/profiles/nix-index.nix)];

  programs = {
    command-not-found.enable        = lib.mkDefault false;
    nix-index-database.comma.enable = lib.mkDefault true;
  };
}
