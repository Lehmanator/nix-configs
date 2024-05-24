{ inputs, cell, }@commonArgs: {
  src = ../packages;
}
#let
#  inherit (inputs.omnibus) pops;
#in
#pops.packages.addLoadExtender {
#  load = {
#    src = ../packages;
#    inputs = {
#      inherit cell;
#      inputs = inputs // {
#        #nixpkgs = inputs.nixpkgs.legacyPackages.${self.system};
#        inherit (inputs) nixpkgs;
#      };
#    };
#  };
#}
