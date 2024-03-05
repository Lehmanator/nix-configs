{ inputs, cell, }:
let inherit (inputs.haumea.lib) load loaders transformers;
in load {
  src = ./nixosModules;
  loader = loaders.verbatim;
  transformer = transformers.liftDefault;
}
