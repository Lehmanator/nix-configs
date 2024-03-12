{ inputs, config, lib, pkgs, ... }: {
  imports = [
    inputs.cell.diskoProfiles.btrfs-luks.nix
    inputs.cell.diskoProfiles.tmpfs-root
  ];
}
