{inputs, cell}@commonArgs:
inputs.omnibusStd.mkBlocks.pops commonArgs {
  packages = {src = ./packages; };
}
