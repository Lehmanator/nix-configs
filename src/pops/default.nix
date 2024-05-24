{ inputs, ... }@commonArgs:
#builtins.trace
#  (builtins.concatStringsSep "\n" [
#    "src/pops/default.nix"
#    "system = ${inputs.nixpkgs.system or builtins.currentSystem}"
#    "  args = ${builtins.concatStringsSep "," (builtins.attrNames commonArgs)}"
#    "inputs = ${builtins.concatStringsSep "," (builtins.attrNames inputs)}"
#    ""
#  ])
{
  # flops
  flake = inputs.omnibus.inputs.flops.lib.flake.pops;
  configs = inputs.omnibus.inputs.flops.lib.configs.pops;
  haumea = inputs.omnibus.inputs.flops.lib.haumea.pops;

  # omnibus
  hivebus = inputs.hivebus.pops;
  omnibus = inputs.omnibus.pops;

  # mine
  hive = inputs.self.pops-hive;
  me = inputs.self.pops;

  # this dir
} // (inputs.omnibus.pops.load {
  src = ./.;
  transformer = [ inputs.omnibus.lib.haumea.removeTopDefault ];
  inputs = commonArgs // {
    inputs = inputs.omnibus.lib.omnibus.loaderInputs // inputs;
    #lehmanator-flakeRoot = ../.;
    #lehmanator-popSrc = "top";
  };
}).exports.default
