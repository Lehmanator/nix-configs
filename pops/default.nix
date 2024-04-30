{ inputs, omnibus, omnibusStd, self, ... }@args:
#omnibusStd.mkBlocks.pops args
rec {
  #flake = omnibus.pops.flake.addInputsExtender
  #  (POP.extendPop flops.flake.pops.inputsExtender (_self: _super:
  #    let
  #      subflake = omnibus.pops.flake.setInitInputs (self + /pops/.lock);
  #      #subflake = omnibus.pops.flake.setInitInputs (projectRoot + /nix/lock);
  #    in
  #    { inherit (subflake) inputs; } # inputs = subflake.inputs;
  #  ));
  #
  hive = omnibus.pops.hive.setHosts hosts.exports.default;
  hosts = omnibus.pops.load {
    src = self + /nix/hive/hosts;
    inputs = {
      inherit (inputs) nixos-unstable;
      inputs = inputs // { };
    };
  };
  pop = omnibus.pops.std {
    inputs.projectRoot = ./.;
    inputs.inputs = inputs // omnibus.flake.inputs; # mergedInputs;
    #inputs.inputs = { inherit (omnibus.flake.inputs) std; };
    #{
    #  inherit (omnibus.flake) inputs;
    #  inherit (inputs) haumea std;
    #};
  };
}
