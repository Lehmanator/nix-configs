{ inputs, config, lib, pkgs, ... }:
let
  implementation = "divnix";
in
lib.mkMerge [
  (lib.mkIf implementation == "divnix" {
    imports = [ inputs.quick-nix-registry.nixosModules.local-registry ];
    nix.localRegistry = {
      enable = lib.mkDefault true;
      cacheGlobalRegistry = lib.mkDefault true;
      noGlobalRegistry = lib.mkDefault false;
    };
  }) 
  (lib.mkIf implementation == "flake-utils-plus" {
    imports = [ inputs.flake-utils-plus.nixosModules.autoGenFromInputs ];
    nix = {
      generateRegistryFromInputs = lib.mkDefault true;
      generateNixPathFromInputs = lib.mkDefault true;
      linkInputs = lib.mkDefault true;
    };
  })
]
