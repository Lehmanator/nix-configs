{ inputs, cell, }@commonArgs:
let
  inherit (inputs) omnibusStd cellsFrom cellsFrom' _pops;
  cellName = builtins.baseNameOf ../.;
in
inputs.omnibus.pops.flake-parts.addLoadExtender {
  load = {
    src = cellsFrom + /${cellName}/flake-parts;
    inputs = { inherit inputs cell; };
  };
}
