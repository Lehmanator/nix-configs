{
  inputs,
  lib,
  config,
  ...
}: let
  inherit (inputs.haumea.lib) load loaders matchers transformers;

  modules = [];
  specialArgs = {
    inherit inputs;
    user = "sam";
  };
in {
  imports = [
    #inputs.ez-configs.flakeModules.ez-configs
  ];

  perSystem = {
    config,
    pkgs,
    system,
    ...
  }: {
    #packages = load {
    #  src = ./packages;
    #  #loader = loaders.callPackage;
    #  loader = inputs: path:
    #    if path != ./packages
    #    then
    #      pkgs.callPackage path {
    #        inherit inputs pkgs;
    #        inherit (pkgs) lib;
    #      }
    #    else null;
    #  matchers = matchers.nix;
    #  transformers = transformers.liftDefault;
    #  inputs = {inherit lib pkgs inputs system;};
    #};

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
      src = ./lib;
      inputs = {
        inherit inputs lib;
        inherit (inputs.nixpkgs) legacyPackages; # lib;
      };
    };

    # TODO: Merge in nixosProfiles, prefixed with "profile-"
    #nixosModules = load {
    #  src = ./modules;
    #};

    nixosModules = load {
      src = ./profiles;
      inputs = {inherit lib;};
      loader = loaders.verbatim;
      transformer = transformers.liftDefault;
    };
    #nixosModules.installer = import ./profiles/installer.nix;
    nixosProfiles = load {
      src = ./profiles;
      inputs = {inherit lib;};
      loader = loaders.verbatim;
      transformer = transformers.liftDefault;
    };
    nixosSuites = load {
      src = ./suites;
      inputs = {inherit lib;};
      loader = loaders.verbatim;
      transformer = transformers.liftDefault;
    };

    #nixosConfigurations = load {
    #  src = ./configs;
    #};

    #overlays = import ./overlays;
  };
}
