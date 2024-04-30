{ inputs, cell, }:
let
  #
  inherit (inputs) self;
in
{ host
, system ? "x86_64-linux"
, user ? "sam"
, modules ? [ ]
, self ? inputs.self
, ...
}@args:
#(cell.lib.lehmanatorSystem { inherit inputs self; }) {
cell.lib.lehmanatorSystem {
  inherit system;
  specialArgs = { inherit inputs user; };
  modules = [ "${inputs.self}/hosts/${host}" ] ++ modules;
}
# --- ORIGINAL --------------------------------------------
#mkSystem =
#  { host
#  , system ? "x86_64-linux"
#  , user ? "sam"
#  , modules ? [ ]
#  , ...
#  }@args:
#  (import ./nix/hive/lib/lehmanatorSystem.nix {
#    inherit inputs self;
#  }) {
#    inherit system;
#    specialArgs = {
#      inherit inputs user;
#      debug = false;
#    };
#    modules = [ ./hosts/${host} ] ++ modules;
#  };
# --- ORIGINAL --------------------------------------------
