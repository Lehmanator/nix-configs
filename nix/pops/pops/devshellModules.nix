{ inputs, cell, }@commonArgs:
inputs.omnibus.pops.devshellModules.addLoadExtender {
  load = {
    src = cellsFrom + /${cellName}/devshellModules;
    inputs = { inherit inputs cell; };
  };
}
