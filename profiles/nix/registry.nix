{ inputs, config, lib, pkgs, ... }:
{
  imports = [ inputs.nix-quick-registry.nixosModules.local-registry ];
  # User: ~/.config/nix/registry.json
  # Create Nix registry from nixpkgs
  # TODO: Select input based on system type
  #nix.registry.nixpkgs.flake = inputs.nixpkgs;
  nix = {
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    #registry = {
    #  nixos.flake = inputs.nixos;
    #  darwin.flake = inputs.darwin;
    #  nixpkgs = {
    #    #from = {
    #    #  id = "nixpkgs";
    #    #  type = "indirect";
    #    #};
    #    flake = inputs.nixpkgs;
    #  };
    #  home-manager.flake = inputs.home;
    #  home.flake = inputs.home;
    #  #repo = {
    #  #  to = { type = "github";
    #  #    owner = "PresqueIsleWineDev";
    #  #    repo = "nix-configs";
    #  #  };
    #  #};
    #};
    localRegistry = {
      enable = true;
      cacheGlobalRegistry = true;
      noGlobalRegistry = false;
    };
    settings = {
      use-registries = true;
      flake-registry = true;
    };
  };
}
