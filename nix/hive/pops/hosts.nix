{ inputs, cell, }@commonArgs:
#mkHosts {
#  hostsDir = ./hosts;
#  pops = super.hostsInterface;
#  addLoadExtender = {
#    load = { inputs = { inherit inputs; }; };
#  };
#};
inputs.hivebus.pops.hosts.addLoadExtender {
  load = {
    src = inputs.omnibus.flake.inputs.std.incl ../hosts [
      "darwin-test"
      #"fajita"
      #"fajita-minimal"
      "fw"
      "h1"
      "minimal"
      "test"
      #"wyse"
    ];
    inputs = {
      inherit cell;
      inputs = inputs.omnibus.flake.inputs // inputs // {
        nixosModules = cell.lib.collectFromInputs.nixosModules
          (inputs // inputs.omnibus.flake.inputs);
        hmModules = cell.lib.collectFromInputs.hmModules
          (inputs // inputs.omnibus.flake.inputs);
        overlays = cell.lib.collectFromInputs.overlays
          (inputs // inputs.omnibus.flake.inputs);
      };
    };
  };
}
