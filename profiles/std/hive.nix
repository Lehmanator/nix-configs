{ inputs, ... }: {
  std = {
    #grow = {
    #  nixpkgsConfig = {
    #    allowUnfree = true;
    #    overlays = [ inputs.nix-vscode-extensions.overlays.default ];
    #  };
    #};
    harvest = {
      devShells = [ [ "hive" "shells" ] ];
      diskoConfigurations = [ [ "hive" "diskoConfigurations" ] ];
      packages = [ [ "hive" "packages" ] ];
    };
    pick = {
      devshellProfiles = [ [ "hive" "devshellProfiles" ] ];
      diskoProfiles = [ [ "hive" "diskoProfiles" ] ];
      lib = [ [ "hive" "lib" ] ];
      pops = [ [ "hive" "pops" ] ];
      homeModules = [ [ "hive" "homeModules" ] ];
      homeProfiles = [ [ "hive" "homeProfiles" ] ];
      nixosModules = [ [ "hive" "nixosModules" ] ];
      nixosProfiles = [ [ "hive" "nixosProfiles" ] ];
      nixosSuites = [ [ "hive" "nixosSuites" ] ];
    };
  };
}
