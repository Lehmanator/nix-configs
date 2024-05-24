{ inputs, cell, }:
inputs.omnibus.pops.nixosProfiles.addLoadExtender {
  load = {
    src = ../hardware/profiles;
    type = "nixosProfiles";
    inputs = builtins.removeAttrs
      (inputs // {
        inherit (inputs.omnibus.flake.inputs) disko nixos-hardware;
      }) [ "self" ];
  };
}
