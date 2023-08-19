{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
    inputs.nix-quick-registry.nixosModules.local-registry
  ];

  # --- Nix Registry ---------------------------------------
  # User: ~/.config/nix/registry.json
  # Create Nix registry from nixpkgs
  # TODO: Select input based on system type
  #nix.registry.nixpkgs.flake = inputs.nixpkgs;
  nix = {
    registry = {
      nixos.flake = inputs.nixos;
      darwin.flake = inputs.darwin;

      #repo = {
      #  to = { type = "github";
      #    owner = "PresqueIsleWineDev";
      #    repo = "nix-configs";
      #  };
      #};
    };
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