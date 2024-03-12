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
      packages = [ [ "hive" "packages" ] ];

      darwinConfigurations = [ [ "hive" "darwinConfigurations" ] ];
      diskoConfigurations = [ [ "hive" "diskoConfigurations" ] ];
      #homeConfigurations = [ [ "hive" "homeConfigurations" ] ];
      nixosConfigurations = [ [ "hive" "nixosConfigurations" ] ];
    };
    pick = {
      lib = [ [ "hive" "lib" ] ];
      pops = [ [ "hive" "pops" ] ];
      pops-hive = [ [ "hive" "pops" ] ];

      #devshellConfigurations = [ [ "hive" "devshellConfigurations" ] ];
      #devshellModules = [ [ "hive" "devshellModules" ] ];
      devshellSuites = [ [ "hive" "devshellSuites" ] ];
      devshellProfiles = [ [ "hive" "devshellProfiles" ] ];

      diskoConfigurations = [ [ "hive" "diskoConfigurations" ] ];
      diskoProfiles = [ [ "hive" "diskoProfiles" ] ];
      #diskoModules = [ [ "hive" "diskoModules" ] ];
      diskoSuites = [ [ "hive" "diskoSuites" ] ];

      #flakeConfigurations = [ [ "hive" "flakeConfigurations" ] ];
      #flakeModules = [ [ "hive" "flakeModules" ] ];
      #flakeProfiles = [ [ "hive" "flakeProfiles" ] ];
      #flakeSuites = [ [ "hive" "flakeSuites" ] ];

      #hardwareConfigurations = [ [ "hive" "hardwareConfigurations" ] ];
      #hardwareModules = [ [ "hive" "hardwareModules" ] ];
      hardwareProfiles = [ [ "hive" "hardwareProfiles" ] ];
      hardwareSuites = [ [ "hive" "hardwareSuites" ] ];

      homeConfigurations = [ [ "hive" "homeConfigurations" ] ];
      homeModules = [ [ "hive" "homeModules" ] ];
      homeProfiles = [ [ "hive" "homeProfiles" ] ];
      homeSuites = [ [ "hive" "homeSuites" ] ];

      #nixosConfigurations = [ [ "hive" "nixosConfigurations" ] ];
      nixosModules = [ [ "hive" "nixosModules" ] ];
      nixosProfiles = [ [ "hive" "nixosProfiles" ] ];
      nixosSuites = [ [ "hive" "nixosSuites" ] ];

      #nixvimConfigurations = [ [ "hive" "nixvimConfigurations" ] ];
      nixvimModules = [ [ "hive" "nixvimModules" ] ];
      nixvimProfiles = [ [ "hive" "nixvimProfiles" ] ];
      nixvimSuites = [ [ "hive" "nixvimSuites" ] ];
    };
  };
}
