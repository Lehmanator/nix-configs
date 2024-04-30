{
  inputs,
  cell,
} @ commonArgs:
inputs.omnibusStd.mkBlocks.pops commonArgs {
  #configs = {src = ./configs; };
  #devshellProfiles = {src = ./devshellProfiles; };
  #nixosProfiles = {src = ./nixosProfiles; };
  nixosModules = {src = ./nixosModules;};
  packages = {
    src = ./packages;
    inputs = {inherit inputs cell;};
  };
  #shells = {src = ./shells;};
}
