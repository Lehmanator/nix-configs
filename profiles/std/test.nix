{ inputs, ... }: {
  std.harvest = {
    devShells = [ [ "test" "shells" ] ];
    packages = [ [ "test" "packages" ] ];
  };
  std.pick = {
    configs = [ [ "test" "configs" ] ];
    devshellProfiles = [ [ "test" "devshellProfiles" ] ];
    nixosModules = [ [ "test" "nixosModules" ] ];
    nixosProfiles = [ [ "test" "nixosProfiles" ] ];
    popsTester = [ [ "test" "pops" ] ];
  };
}
