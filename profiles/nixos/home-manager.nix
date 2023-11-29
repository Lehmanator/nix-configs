{ inputs
, user
, config
, lib
, pkgs
, ...
}:
{
  imports = [ inputs.home.nixosModules.home-manager ];
  home-manager = {
    sharedModules = with inputs; [
      #arkenfox.hmModules.default
      nix-index.hmModules.nix-index
      { programs.nix-index-database.comma.enable = true; }
    ];
    useGlobalPkgs = false;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs user; };
    users.${user} = import ../../users/${user};
  };
}
