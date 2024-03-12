{ inputs, ... }: {
  std.harvest = {
    devShells = [ [ "test" "shells" ] ];
    packages = [ [ "test" "packages" ] ];
  };
  std.pick = {
    configs = [ [ "test" "configs" ] ];
    data-repo = [ [ "test" "data" ] ];
    devshellProfiles = [ [ "test" "devshellProfiles" ] ];
    nixosModules = [ [ "test" "nixosModules" ] ];
    nixosProfiles = [ [ "test" "nixosProfiles" ] ];
    pops-test = [ [ "test" "pops" ] ];
  };
}
