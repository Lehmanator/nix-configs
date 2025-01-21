{ inputs, config, lib, pkgs, ... }:
# let
#   implementation = "flake-utils-parts";
# in
# if implementation=="flake-utils-parts" then
{
  imports = [ inputs.flake-utils-plus.nixosModules.autoGenFromInputs ];
  nix = {
    generateRegistryFromInputs = lib.mkDefault true;
    generateNixPathFromInputs  = lib.mkDefault true;
    linkInputs = lib.mkDefault true;
  };
}
# else
# {
#   imports = [ inputs.quick-nix-registry.nixosModules.local-registry ];
#   nix.localRegistry = {
#     enable = lib.mkDefault true;
#     cacheGlobalRegistry = lib.mkDefault true;
#     noGlobalRegistry = lib.mkDefault false;
#   };
# }
