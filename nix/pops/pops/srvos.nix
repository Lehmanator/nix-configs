{
  inputs,
  cell,
} @ commonArgs: let
  inherit (inputs) omnibusStd cellsFrom cellsFrom' _pops;
  cellName = builtins.baseNameOf ../.;
in
  inputs.omnibus.pops.srvos.addLoadExtender {
    load = {
      src = cellsFrom + /${cellName}/srvos;
      inputs = {inherit inputs cell;};
    };
  }
