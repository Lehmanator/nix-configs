{
  inputs,
  cell,
} @ commonArgs: let
  inherit (inputs) omnibusStd cellsFrom cellsFrom' _pops;
  cellName = builtins.baseNameOf ../.;
in
  inputs.omnibus.pops.allData.addLoadExtender {
    load = {
      src = cellsFrom + /${cellName}/allData;
      inputs = {inherit inputs cell;};
    };
  }
