{ inputs, ... }:
let
  inherit (inputs.haumea.lib) load loaders matchers transformers;

  modules = [
  ];
  specialArgs = {
    inherit inputs;
    user = "sam";
  };

in
{
  imports = [
    #inputs.ez-configs.flakeModules.ez-configs
  ];

  perSystem = { config, lib, pkgs, system, ... }:
  {
    packages = load {
      src = ./packages;
      loader = loaders.callPackage;
      inputs = {
        inherit lib pkgs inputs system;
      };
      #transformers = ;
    };

    #devshellProfiles = load {
    #  src = ./devshellProfiles;
    #  loader = loaders.default;
    #  inputs = {
    #    inherit lib pkgs system;
    #    inherit inputs;
    #  };
    #};

    #devshells.nixos = {
    #};

  };

  flake = {

    # TODO: Handle libs that require args: config, lib, pkgs, ...
    lib.nixos = load {
      src = ./lib
      inputs = {
        inherit inputs.nixpkgs.lib;
        inherit inputs.nixpkgs.legacyPackages;
        inherit inputs;
      };
    };

    # TODO: Merge in nixosProfiles, prefixed with "profile-"
    nixosModules = load {
      src = ./modules;
    };

    nixosProfiles = load {
      src = ./profiles;
    };

    nixosSuites = load {
      src = ./suites;
    };

    nixosConfigurations = load {
      src = ./configs;
    };

    overlays = import ./overlays;
  };

}
