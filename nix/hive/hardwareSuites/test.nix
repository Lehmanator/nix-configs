{ inputs, config, lib, pkgs, ... }: {
  imports = [ inputs.cell.hardwareProfiles.disk-nvme ];
}
