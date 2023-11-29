{ inputs
, config
, lib
, pkgs
, modulesPath
, user
, ...
}:
{
  # Modules to load for all home-manager configurations
  sharedModules = with inputs; [
    impermanence.nixosModules.home-manager
    nixpkgs-android.hmModule
    arkenfox.hmModules.default
    sops-nix.homeManagerModules.sops
  ];
  extraSpecialArgs = { inherit inputs user; };
  useGlobalPkgs = false;
  useUserPackages = true;
  users.${user} = import ../../users/${user};
}
