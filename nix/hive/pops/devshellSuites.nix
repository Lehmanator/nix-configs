{ inputs, cell, }@commonArgs:
inputs.omnibus.pops.nixosProfiles.addLoadExtender {
  load = {
    src = ../devshell/suites;
    type = "nixosProfiles";
    inputs = {
      inherit cell;
      inputs = {
        inherit (inputs.omnibus.flake.inputs) climodSrc devshell std;
      } // inputs;
    };
  };
}
