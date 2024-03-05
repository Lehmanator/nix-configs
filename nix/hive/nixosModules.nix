{
  inputs,
  cell,
}: let
  inherit (inputs.haumea.lib) load loaders matchers transformers;
in
  load {
    src = ./nixosModules;
    loader = loaders.verbatim;
    transformer = transformers.liftDefaults;
  }
