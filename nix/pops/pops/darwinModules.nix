{ inputs, cell, }@commonArgs:
let
  inherit (inputs) omnibusStd cellsFrom cellsFrom' _pops;
  cellName = builtins.baseNameOf ../.;
in
inputs.omnibus.pops.darwinModules.addLoadExtender {
  load = {
    src = cellsFrom + /${cellName}/darwinModules;
    inputs = { inherit inputs cell; };
  };
}
