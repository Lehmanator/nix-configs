{ cell, config, lib, pkgs, ... }:
{
  imports = [
    cell.nixosProfiles.filesystems-bcachefs
    cell.nixosProfiles.filesystems-btrfs
    cell.nixosProfiles.filesystems-lvm2
    cell.nixosProfiles.filesystems-mdadm
    cell.nixosProfiles.filesystems-ntfs
    # cell.nixosProfiles.filesystems-btrfs-disko
    # cell.nixosProfiles.filesystems-zfs
    # cell.nixosProfiles.filesystems-nvme
  ];

  boot = {
    hardwareScan = true;
    initrd.includeDefaultModules = true;
    #modprobeConfig.enable = true;
    #extraModprobeConfig = ''
    #'';

    # --- FUSE ---
    #availableKernelModules=["fuse"];
    #kernelModules=["fuse"];

  };
}
