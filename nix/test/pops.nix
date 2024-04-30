{ inputs, cell, }@commonArgs:
inputs.omnibusStd.mkBlocks.pops commonArgs {
  configs = { src = ./configs; };
  data = { src = ./data; };
  devshellProfiles = { src = ./devshellProfiles; };
  #jupyenv = { src = ./jupyenv; };
  nixosModules = { src = ./nixosModules; };
  nixosProfiles = {
    src = ./nixosProfiles;
    type = "nixosProfiles";
  };
  packages = { src = ./packages; };
  #scripts = { src = ./scripts; };
  shells = { src = ./shells; };
  #tasks = { src = ./tasks; };
}
