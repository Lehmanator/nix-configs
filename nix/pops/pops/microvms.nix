{ inputs, cell, }@commonArgs:
let
  inherit (inputs) omnibusStd cellsFrom cellsFrom' _pops;
  cellName = builtins.baseNameOf ../.;
in
inputs.omnibus.pops.microvms.addLoadExtender {
  load = {
    src = cellsFrom + /${cellName}/microvms;
    inputs = { inherit inputs cell; };
  };
}
