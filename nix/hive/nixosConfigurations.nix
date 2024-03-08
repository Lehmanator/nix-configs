{ inputs, cell, }: cell.pops.nixosConfigurations.exports.default
#let
#  inherit (inputs.haumea.lib) load loaders matchers transformers;
#in
#  load {
#    src = ./nixosConfigurations;
#    loader = loaders.verbatim;
#    transformer = transformers.liftDefaults;
#  }
