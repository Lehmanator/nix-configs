{ inputs, config, lib, pkgs, ... }: {
  imports = [
    inputs.cell.devshellProfiles.benchmarking
    inputs.cell.devshellProfiles.normalize
  ];
}
