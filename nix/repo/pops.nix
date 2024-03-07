{ inputs, cell, }@commonArgs:
let inherit (inputs) omnibusStd;
in omnibusStd.mkBlocks.pops commonArgs {
  configs = { src = ./configs; };
  devshellProfiles = { src = ./devshellProfiles; };
  nixosProfiles = { src = ./nixosProfiles; };
  shells = { src = ./shells; };
}
