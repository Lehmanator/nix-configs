{ inputs, lib, ... }: {
  # Compare with inputs.self.nixosProfiles.flake-utils-plus
  imports = [ inputs.quick-nix-registry.nixosModules.local-registry ];
  nix.localRegistry = {
    enable = lib.mkDefault true;
    cacheGlobalRegistry = lib.mkDefault true;
    noGlobalRegistry = lib.mkDefault false;
  };
}
