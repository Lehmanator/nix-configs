{ inputs, cell, }@commonArgs:
inputs.omnibus.pops.homeProfiles.addLoadExtender {
  load = {
    src = ../vim/configs;
    type = "nixosProfiles";
    inputs = {
      inherit cell;
      inputs = (builtins.removeAttrs inputs [ "self" ]) // {
        inherit (inputs) nixvim;
      };
    };
  };
}
