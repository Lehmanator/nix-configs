{ inputs, cell, }@commonArgs:
let
  inherit (inputs) omnibusStd cellsFrom cellsFrom' _pops;
  cellName = builtins.baseNameOf ../.;
in
inputs.omnibus.pops.flake.addLoadExtender {
  load = {
    src = cellsFrom + /${cellName}/flake;
    inputs = { inherit inputs cell; };
  };
}
