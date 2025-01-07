{ config, lib, pkgs, ... }:
{
  # --- BTRFS Support ---
  # TODO: profiles/hardware/disks/btrfs-dedup.nix (services.beesd)
  boot = {
    supportedFilesystems = [ "btrfs" ];
    initrd = {
      availableKernelModules = [ "btrfs" ];
      includeDefaultModules = true;
      kernelModules = [ "btrfs" ];
      supportedFilesystems = [ "btrfs" ];
      # systemd.extraBin = [ pkgs.btrbk pkgs.btrfs-progs ]; # Packages to include in /bin for the stage 1 emergency shell
      systemd.initrdBin = [ pkgs.btrbk pkgs.btrfs-progs ]; # Packages to include in /bin for the stage 1 emergency shell
    };
  };

  # environment.systemPackages = [
  #   pkgs.bees                  # 
  #   pkgs.btdu                  #
  #   pkgs.btrbk                 #
  #   pkgs.btrfs-auto-snapshot   # 
  #   pkgs.btrfs-heatmap         # 
  #   pkgs.btrfs-progs           # 
  #   pkgs.btrfs-snap            # 
  #   # pkgs.btrfs-assistant       #
  #   pkgs.ntfs2btrfs            # CLI for in-place conversion of Microsoft's NTFS fs to BTRFS
  # ];
}
