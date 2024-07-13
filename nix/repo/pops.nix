{ inputs, cell, }@commonArgs:
let 
  inherit (inputs) omnibusStd;
in
# TODO: Migrate to new directory structure.
#   i.e. `./shells/{configs,modules,profiles,suites}`
omnibusStd.mkBlocks.pops commonArgs {
  actions = { src = ./actions; };
  blockTypes = {src = ./blockTypes; };
  # packages = { src = ./packages; };

  configs = { src = ./configs; };

  devshellProfiles = {
    src = ./devshellProfiles;
    type = "nixosProfiles";
  };

  nixosProfiles = {
    src = ./nixosProfiles;
    type = "nixosProfiles";
  };

  shells = { src = ./shells; };

  lib = inputs.omnibus.pops.load {
    src = ./lib;
    loader = inputs.haumea.lib.loaders.default;
    inputs = commonArgs;
  };

}
