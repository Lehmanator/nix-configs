{ inputs, cell, }@commonArgs:
inputs.omnibus.pops.load {
  src = ../lib;
  loader = inputs.haumea.lib.loaders.default;
  inputs = { inherit inputs cell; };
}
