{ inputs, cell, }@commonArgs:
inputs.omnibus.pops.nixosModules.addLoadExtender {
  load = {
    src = ../devshell/modules;
    #inputs = {
    #  inherit cell;
    #  inputs = { inherit (inputs.omnibus.flake.inputs) climodSrc devshell; };
    #};
  };
}
