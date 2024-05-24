{ inputs, cell, }@commonArgs:
inputs.omnibus.pops.nixosProfiles.addLoadExtender {
  load = {
    src = ../disko/configs;
    inputs = {
      inherit cell;
      inputs = inputs // { inherit (inputs.omnibus.flake.inputs) disko; };
    };
  };
}
