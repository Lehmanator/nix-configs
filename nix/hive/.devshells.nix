{ inputs, cell, }:
let
  l = inputs.nixpkgs.lib // builtins;
  inherit (inputs.haumea.lib) load loaders matchers transformers;
  #l.mapAttrs (_: inputs.std.lib.dev.mkShell) (load {
in
{ }
#load {
#  src = ./shells;
#  loader = loaders.verbatim;
#  #loader = i: path: inputs.std.lib.dev.mkShell (import path { inherit inputs cell; });
#  transformer = transformers.liftDefault;
#  inputs = { inherit inputs cell; };
#}
