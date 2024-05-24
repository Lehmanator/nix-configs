{ inputs, cell, }@commonArgs:
inputs.omnibus.pops.nixosProfiles.addLoadExtender {
  load = {
    src = ../disko/profiles;
    type = "nixosProfiles";
    inputs = {
      inherit cell;
      inputs = inputs // { inherit (inputs.omnibus.flake.inputs) disko; };
    };
  };
}
