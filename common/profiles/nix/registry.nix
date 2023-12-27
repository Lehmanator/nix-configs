{ inputs, config, lib, pkgs, ... }:
{
  imports = [
    #inputs.nix-quick-registry.nixosModules.local-registry
    #inputs.flake-utils-plus.nixosModules.autoGenFromInputs
  ];

  nix = {
    generateNixPathFromInputs = true;
    generateRegistryFromInputs = true;
    linkInputs = true;
    #localRegistry = {
    #  enable = true;
    #  cacheGlobalRegistry = true;
    #  noGlobalRegistry = false;
    #};
    settings = {
      use-registries = true;
      flake-registry = true;
    };
  };
}
