{ inputs, cell, }@commonArgs:
let
  inherit (inputs) omnibusStd cellsFrom cellsFrom' _pops;
  cellName = builtins.baseNameOf ../.;
in
inputs.omnibus.pops.darwinProfiles.addLoadExtender {
  load = {
    src = cellsFrom + /${cellName}/darwinProfiles;
    inputs = { inherit inputs cell; };
  };
}
