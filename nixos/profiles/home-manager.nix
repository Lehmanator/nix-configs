{ inputs
, user
, config
, lib
, pkgs
, ...
}:
{
  imports = [ inputs.home.nixosModules.home-manager ];
  home-manager = lib.mkIf (config.networking.hostName != "fajita") {
    sharedModules = with inputs; [
      #arkenfox.hmModules.default
      #sops.homeManagerModules.sops
      nix-index.hmModules.nix-index
      { programs.nix-index-database.comma.enable = true; }
    ];
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs user; };
    users.${user} = import ../../users/${user};
  };
}
