{ inputs, cell, }@commonArgs:
let
  inherit (inputs) omnibusStd cellsFrom cellsFrom' _pops;
  cellName = builtins.baseNameOf ../.;
in
inputs.omnibus.pops.systemManagerProfiles.addLoadExtender {
  load = {
    src = cellsFrom + /${cellName}/systemManagerProfiles;
    inputs = { inherit inputs cell; };
  };
}
