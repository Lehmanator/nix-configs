{ inputs, ... }: {
  std.harvest = {
    #devShells = [ [ "android" "shells" ] ];
    packages = [ [ "android" "packages" ] ];
  };
  #std.pick = {
  #  configs = [ [ "android" "configs" ] ];
  #  devshellProfiles = [ [ "android" "devshellProfiles" ] ];
  #  nixosModules = [ [ "android" "nixosModules" ] ];
  #  nixosProfiles = [ [ "android" "nixosProfiles" ] ];
  #  popsTester = [ [ "android" "pops" ] ];
  #};
}
