{ inputs, cell, }@commonArgs: {
  # TODO: Write full pop definition here,
  #  not just attrset passed to `omnibusStd.mkBlocks.pops`
  src = ../nixos/modules;
  #inputs = commonArgs // {
  #  inputs = inputs // inputs.omnibus.lib.loaderInputs;
  #  user = "sam";
  #};
}
