{ inputs, config, lib, pkgs, modulesPath, ... }:
{
  imports = [
  ];

  # --- BTRFS Support ---
  # TODO: profiles/hardware/disks/btrfs-dedup.nix (services.beesd)
  boot = {
    supportedFilesystems = [ "btrfs" ];
    initrd = {
      availableKernelModules = [ "btrfs" ];
      includeDefaultModules = true;
      kernelModules = [ "btrfs" ];
      supportedFilesystems = [ "btrfs" ];
      systemd.extraBin = [ "btrfs" "btrfs-progs" ]; # Packages to include in /bin for the stage 1 emergency shell
      systemd.initrdBin = [ "btrfs" "btrfs-progs" ]; # Packages to include in /bin for the stage 1 emergency shell
    };
  };
}
