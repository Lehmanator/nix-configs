{ inputs, cell, }@commonArgs:
let
  inherit (inputs) omnibusStd cellsFrom cellsFrom' _pops;
  cellName = builtins.baseNameOf ../.;
in
inputs.omnibus.pops.std.addLoadExtender {
  load = {
    src = cellsFrom + /${cellName}/std;
    inputs = { inherit inputs cell; };
  };
}
