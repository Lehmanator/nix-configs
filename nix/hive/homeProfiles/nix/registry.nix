{ inputs, lib, pkgs, ... }: {
  imports = [
    #inputs.nix-quick-registry.nixosModules.local-registry
    inputs.flake-utils-plus.nixosModules.autoGenFromInputs
  ];

  nix = {
    channel.enable = false;
    generateNixPathFromInputs = true;
    generateRegistryFromInputs = true;
    linkInputs = true;

    # divnix/quick-nix-registry
    #localRegistry = {
    #  enable = true;
    #  cacheGlobalRegistry = true;
    #  noGlobalRegistry = false;
    #};
    settings = {
      use-registries = true;
      flake-registry =
        lib.mkDefault "https://channels.nixos.org/flake-registry.json";
    };
  };
}
