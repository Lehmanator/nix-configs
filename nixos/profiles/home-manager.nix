{ inputs, config, lib, pkgs, user, ... }:
{
  imports = [ inputs.home.nixosModules.home-manager ];
  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs user; };
    useGlobalPkgs = true;
    useUserPackages = true;
    verbose = true;
    users.${user} = import (inputs.self + /hm/users/${user});
    sharedModules = [
      # inputs.arkenfox.hmModules.default
      # inputs.sops.homeManagerModules.sops
      # inputs.nixpkgs-android.hmModule
      # inputs.nix-index.hmModules.nix-index
      # { programs.nix-index-database.comma.enable = true; }
    ];
  };
}
