{ inputs, cell, }@commonArgs:
inputs.omnibusStd.mkBlocks.pops {
  templates = inputs.omnibus.pops.load {
    src = ./templates;
    inputs = commonArgs;
  };
}
