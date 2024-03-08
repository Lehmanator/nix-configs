{ inputs, ... }: {
  std = {
    harvest = {
      devShells = [ [ "hive" "shells" ] ];
      diskoConfigurations = [ [ "hive" "diskoConfigurations" ] ];
      packages = [ [ "hive" "packages" ] ];
    };
    pick = {
      diskoProfiles = [ [ "hive" "diskoProfiles" ] ];
      pops = [ [ "hive" "pops" ] ];
      homeModules = [ [ "hive" "homeModules" ] ];
      homeProfiles = [ [ "hive" "homeProfiles" ] ];
      nixosModules = [ [ "hive" "nixosModules" ] ];
      nixosProfiles = [ [ "hive" "nixosProfiles" ] ];
      nixosSuites = [ [ "hive" "nixosSuites" ] ];
    };
  };
}
