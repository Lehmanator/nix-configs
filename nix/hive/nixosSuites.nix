{ inputs, cell, }: cell.pops.nixosSuites.exports.default
#let
#  inherit (inputs.haumea.lib) load loaders transformers;
#in
#  load {
#    src = ./nixosSuites;
#    loader = loaders.verbatim;
#    transformer = transformers.liftDefault;
#  }
