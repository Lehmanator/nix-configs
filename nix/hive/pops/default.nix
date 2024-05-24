{ inputs, cell, }@commonArgs:
# TODO: Remove ../pops.nix & move config here
#  ../pops.nix should be akin to cell.pops.<name>.exports.default
#  ../pops.nix currently calls `inputs.omnibusStd.mkBlocks.pops`
#  ./default.nix (this file) should call `inputs.omnibusStd.mkBlocks.pops`
#
#
#  ../pops.nix should:
#  - Be deleted
#  - Move its config here
#
#
#  ./default.nix (this file) should:
#  - Be responsible for passing POP definitions to std
#  - Contain config to transform pops into std cellBlock
#    e.g. call `inputs.omnibusStd.mkBlocks.pops`
#  - Pass original std cell `commonArgs` here, but renamed to `cellArgs`
#  - Load ./pops.nix to get pop loader POP.
#  - Load ./pops.nix to get pop loader POP.
#
#  ./pops.nix (new file) should:
#  - Be responsible for loading POPs.
#  - Contain the config of this file.
#
let
  cellName = builtins.baseNameOf ../.;
  #inputs.omnibusStd.mkBlocks.pops commonArgs {
  #pops = (
in
#builtins.trace
#  (builtins.concatStringsSep "\n" [
#    "hive/pops/default.nix"
#    "system = ${inputs.nixpkgs.system}"
#    "  args = ${builtins.concatStringsSep "," (builtins.attrNames commonArgs)}"
#    "inputs = ${builtins.concatStringsSep "," (builtins.attrNames inputs)}"
#    ""
#  ])
  inputs.omnibus.pops.load
{
  src = ./.;
  transformer = [ inputs.omnibus.lib.haumea.removeTopDefault ];
  inputs = commonArgs // {
    inherit cellName cell;
    inputs = inputs.omnibus.lib.omnibus.loaderInputs
      // inputs.omnibus.flake.inputs // inputs // {
      #omnibusStd = inputs.omnibusStd;
      inherit (inputs) haumea;
    };
  };
}
#  ).exports.default;
#}
