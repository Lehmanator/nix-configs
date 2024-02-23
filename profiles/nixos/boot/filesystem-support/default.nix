{ inputs, config, lib, pkgs, modulesPath, ... }:
{
  imports = [
    ./bcachefs.nix
    ./btrfs.nix
    #./f2fs.nix # ???
    #./fuse.nix # ???
    #./luks.nix # ???
    #./lvm2.nix
    ./mdadm.nix
    ./ntfs.nix
    #./nvme.nix # ???
    ./zfs.nix
  ];

  # --- FUSE ---
  #boot.availableKernelModules=["fuse"];
  #boot.kernelModules=["fuse"];

  boot.hardwareScan = true;
  boot.initrd.includeDefaultModules = true;
  #boot.modprobeConfig.enable = true;
  #boot.extraModprobeConfig = ''
  #'';
}
