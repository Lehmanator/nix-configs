{ inputs, config, lib, pkgs, ... }:
{
  imports = [
    inputs.nix-quick-registry.nixosModules.local-registry
    inputs.flake-utils-plus.nixosModules.autoGenFromInputs
  ];

  nix = {
    generateNixPathFromInputs = true;
    generateRegistryFromInputs = true;
    linkInputs = true;
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
#registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
#nixPath = lib.mapAttrsToList (key: value: "${key}=${value.flake.outPath}") config.nix.registry;
#environment.etc."nixtest" = lib.mapAttrs'
#  (fname: flake: {
#    name = "nix/inputs2/${fname}";
#    value = flake.outPath;
#  })
#  inputs;

#environment.etc = lib.mapAttrs' (name: value: lib.nameValuePair ("nix/inputs/${name}".source) (value.outPath)) inputs;

