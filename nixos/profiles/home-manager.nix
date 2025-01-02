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
      # inputs.nixpkgs-android.hmModule
    ];
  };
}
