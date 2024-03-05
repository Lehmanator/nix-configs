{
  inputs,
  cell,
}: let
  inherit (inputs.haumea.lib) load loaders matchers transformers;
in
  load {
    src = ./nixosProfiles;
    loader = loaders.verbatim;
    transformer = transformers.liftDefault;
  }
