{ inputs, cell, }@commonArgs:
inputs.omnibus.pops.homeModules.addLoadExtender {
  load = {
    src = ../vim/modules;
    #type = "nixosModules";
    inputs = commonArgs;
  };
}
