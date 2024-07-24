{ inputs, config, lib, pkgs, ... }:
{
  imports = [
    #inputs.nix-quick-registry.nixosModules.local-registry
    #inputs.flake-utils-plus.nixosModules.autoGenFromInputs
  ];

  nix = {
    # generateNixPathFromInputs = lib.mkDefault true;
    # generateRegistryFromInputs = lib.mkDefault true;
    # linkInputs = lib.mkDefault true;
    #localRegistry = {
    #  enable = true;
    #  cacheGlobalRegistry = true;
    #  noGlobalRegistry = false;
    #};
    settings = {
      use-registries = lib.mkDefault true;
      # flake-registry = lib.mkDefault "https://channels.nixos.org/flake-registry.json";
    };
  };
}
