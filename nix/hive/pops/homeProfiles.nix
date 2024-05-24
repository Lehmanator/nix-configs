{ inputs, cell, }@commonArgs: {
  src = ../hm/profiles;
  type = "nixosProfiles";
  transformer = [
    inputs.haumea.lib.transformers.liftDefault
    inputs.omnibus.lib.haumea.removeTopDefault
  ];
  inputs = commonArgs // {
    #inherit inputs cell;
    inputs = (builtins.removeAttrs inputs [ "self" ]) // {
      inherit (inputs.omnibus.flake.inputs) home-manager;
      inherit (inputs) haumea;
    };
  };
}
