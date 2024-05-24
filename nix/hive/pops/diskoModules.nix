{ inputs, cell, }@commonArgs:
inputs.omnibus.pops.nixosModules.addLoadExtender {
  load = {
    src = ../disko/modules;
    inputs = {
      inherit cell;
      inputs = inputs // { inherit (inputs.omnibus.flake.inputs) disko; };
    };
  };
}
