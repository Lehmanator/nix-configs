{
  inputs,
  cell,
} @ commonArgs: let
  inherit (inputs) omnibusStd cellsFrom cellsFrom' _pops;
  cellName = builtins.baseNameOf ./.;
in
  omnibusStd.mkBlocks.pops commonArgs {
    configs = {src = cellsFrom + /${cellName}/nixago;};
    data = {src = cellsFrom + /${cellName}/data;};
    devshellProfiles = {src = cellsFrom + /${cellName}/devshellProfiles;};
    jupyenv = {src = cellsFrom + /${cellName}/jupyenv;};
    packages = {src = cellsFrom + /${cellName}/packages;};
    pops = {src = cellsFrom + /${cellName}/pops;};
    scripts = {src = cellsFrom + /${cellName}/scripts;};
    shells = {src = cellsFrom + /${cellName}/devshells;};
    tasks = {src = cellsFrom + /${cellName}/tasks;};
  }
