{
  inputs,
  cell,
}: let
  inherit (inputs.haumea.lib) load loaders matchers transformers;
in
  load {
    src = ./devshellProfiles;
    loader = loaders.verbatim;
    #matcher = matchers.nix;
    transformer = transformers.liftDefault;
  }
