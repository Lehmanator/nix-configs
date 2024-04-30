{ inputs, config, user, ... }: {
  imports = [ inputs.home.nixosModules.home-manager ];
  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs user; };
    #sharedModules = [ ];
    #sharedModules = with inputs; [
    #  #arkenfox.hmModules.default
    #  #sops.homeManagerModules.sops
    #  nix-index.hmModules.nix-index
    #  { programs.nix-index-database.comma.enable = true; }
    #];
    useGlobalPkgs = true;
    useUserPackages = true;
    verbose = true;
    users.${user} = "${inputs.self}/users/${user}";
    #inputs.self.homeConfigurations."${user}@${config.networking.hostName}";
    #users.${user} = import ../homeConfigurations/${user};
    #users.${user} = import ../../../users/${user};
  };
}
