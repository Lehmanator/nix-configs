{ inputs, cell, }@commonArgs:
cell.pops.homeConfigurations.exports.default
#let
#  inherit (inputs.haumea.lib) load loaders matchers transformers;
#in
#  load {
#    src = ./homeConfigurations;
#    loader = loaders.verbatim;
#    transformer = transformers.liftDefaults;
#  }
