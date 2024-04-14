{ inputs
, systems
, growArgs
, overrides
, omnibusStd
, ...
}:
let
  standardStd =
    inputs.omnibusStd.mkStandardStd (growArgs // { inherit systems; });
  flakePartsArgs = {
    inherit systems;
    imports = [ omnibusStd.flakeModule ];
    debug = true;
    std.std = standardStd;
    harvest = { };
    pick = { };
    winnow = { };
    winnowIf = { };
    flake = overrides // {
      blockTypes.omnibus = omnibusStd.blockTypes;
      omnibus = {
        inherit inputs omnibusStd standardStd;
        inherit (inputs.omnibus) pops;
        inherit (omnibusStd) flakeModule;
        #inputs = {
        #  inherit (input-groups) all grow;
        #  upstream = input-groups.omnibus;
        #  me = inputs;
        #};
      };
    };
  };
in
inputs.omnibus.flake.inputs.flake-parts.lib.mkFlake { inherit inputs; } flakePartsArgs;
