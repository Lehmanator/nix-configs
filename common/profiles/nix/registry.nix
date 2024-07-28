{ inputs, config, lib, pkgs, ... }: {
  # imports = with inputs; [ nix-quick-registry.nixosModules.local-registry flake-utils-plus.nixosModules.autoGenFromInputs ];
  nix.settings = {
    use-registries = lib.mkDefault true;
    # flake-registry = lib.mkDefault "https://channels.nixos.org/flake-registry.json";
  };
}
