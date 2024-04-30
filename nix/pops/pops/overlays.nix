{ inputs, cell, }@commonArgs:
let
  inherit (inputs) omnibusStd cellsFrom cellsFrom' _pops;
  cellName = builtins.baseNameOf ../.;
in
inputs.omnibus.pops.overlays.addLoadExtender {
  load = {
    src = cellsFrom + /${cellName}/overlays;
    inputs = { inherit inputs cell; };
  };
}
