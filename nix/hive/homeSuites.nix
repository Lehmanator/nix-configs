{
  inputs,
  cell,
}: let
  inherit (inputs.haumea.lib) load loaders matchers transformers;
in
  load {
    src = ./homeSuites;
    loader = loaders.verbatim;
    transformer = transformers.liftDefaults;
  }
