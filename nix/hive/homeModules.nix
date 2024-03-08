{ inputs, cell, }: cell.pops.homeModules.exports.default
#let
#  inherit (inputs.haumea.lib) load loaders matchers transformers;
#in
#  load {
#    src = ./homeModules;
#    loader = loaders.verbatim;
#    transformer = transformers.liftDefaults;
#  }
