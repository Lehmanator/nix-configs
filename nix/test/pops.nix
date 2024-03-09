{ inputs, cell, }@commonArgs:
inputs.omnibusStd.mkBlocks.pops commonArgs {
  configs = { src = ./configs; };
  devshellProfiles = { src = ./devshellProfiles; };
  packages = { src = ./packages; };
  shells = { src = ./shells; };

  data = { src = ./data; };
  #jupyenv = { src = ./jupyenv; };
  #scripts = { src = ./scripts; };
  #tasks = { src = ./tasks; };

  nixosModules = { src = ./nixosModules; };
  nixosProfiles = {
    src = ./nixosProfiles;
    type = "nixosProfiles";
  };
}
