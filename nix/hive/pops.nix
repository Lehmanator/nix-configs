{ inputs, cell, }@commonArgs:
let
  #inherit (inputs) omnibusStd;# cellsFrom cellsFrom' _pops ;
  #inherit (inputs.nixpkgs) lib;
  inherit (inputs.omnibus) pops;
  cellName = builtins.baseNameOf ./.;
  mergedInputs = inputs.omnibus.flake.inputs // inputs // {
    #omnibusStd = inputs.omnibusStd;
    inherit (inputs) omnibus omnibusStd;
  };
  # TODO: Which pops are available in `mkBlocks`, omnibus, hivebus?
  #
  # mkBlocks: configs, data, devshellProfiles, jupyenv, packages, pops, scripts, shells, tasks
  #
  # TODO: Kubernetes, containers, tests, checks, jupyenv, nixago, secrets
  # TODO: Try: `src = cellsFrom + /${cellName}/packages;`
  #builtins.trace
  #  (builtins.concatStringsSep "\n" [
  #    "hive/pops.nix"
  #    "system = ${inputs.nixpkgs.system}"
  #    "  args = ${builtins.concatStringsSep "," (builtins.attrNames commonArgs)}"
  #    "inputs = ${builtins.concatStringsSep "," (builtins.attrNames inputs)}"
  #    ""
  #  ])
in
inputs.omnibusStd.mkBlocks.pops commonArgs
  (import ./pops commonArgs).exports.default
#
#
# --- OLD ATTEMPT ------------------------------------------
## Attr args should match that of Haumea load
#
#containers = { src = cellsFrom + /${cellName}/configs; };
#
#robotnixConfigurations = { src = cellsFrom + /${cellName}/robotnixConfigurations; };
#robotnixModules = { src = cellsFrom + /${cellName}/robotnixModules; };
#robotnixProfiles = { src = cellsFrom + /${cellName}/robotnixProfiles; };
#
# --- HELPER LIBRARY ---------------------------------------
#
#configTypes = [ "devshell" "disko" "flake" "hardware" "homeManager" "nixondroid" "nixos" "nixvim" "robotnix" ];
#mkConfigTypes = t: {
#  "${t}Configurations" = {
#    src = cellsFrom + /${cellName}/${t}Configurations;
#  };
#  "${t}Modules" = {
#    src = cellsFrom + /${cellName}/${t}Modules;
#  };
#  "${t}Profiles" = {
#    src = cellsFrom + /${cellName}/${t}Profiles;
#  };
#};
