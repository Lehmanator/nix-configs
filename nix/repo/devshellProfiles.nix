{ inputs, cell, }:
inputs.haumea.lib.load {
  src = ./devshellProfiles;
  loader = inputs.haumea.lib.loaders.verbatim;
  transformer = inputs.haumea.lib.transformers.liftDefault;
}
