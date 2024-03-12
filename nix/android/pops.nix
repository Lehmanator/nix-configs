{ inputs, cell, }@commonArgs:
inputs.omnibusStd.mkBlocks.pops commonArgs {
  #configs = {src = ./configs; };
  #devshellProfiles = {src = ./devshellProfiles; };
  #nixosProfiles = {src = ./nixosProfiles; };
  packages = { src = ./packages; };
  #shells = {src = ./shells; };
}
