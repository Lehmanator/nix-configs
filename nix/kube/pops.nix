{ inputs, cell, }@commonArgs:
let inherit (inputs) omnibusStd;
in omnibusStd.mkBlocks.pops commonArgs {
  #configs = { src = ./configs; };
  devshellProfiles = { src = ./devshellProfiles; };
  nixosModules = { src = ./nixosModules; };
  nixosProfiles = {
    src = ./nixosProfiles;
    type = "nixosProfiles";
  };
  shells = { src = ./shells; };
}
