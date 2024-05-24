{ inputs, cell, }: {
  src = ../hm/suites;
  type = "nixosProfiles";
  inputs = {
    inherit inputs cell;
    #inputs = (builtins.removeAttrs inputs ["self"]) // { inherit (inputs.omnibus.flake.inputs) home-manager;
  };
}
