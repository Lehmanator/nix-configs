{ inputs, config, lib, pkgs, modulesPath, ... }:
{
  imports = [ "${modulesPath}/image/repart.nix" ];

  # --- systemd-repart ---
  # TODO: systemd-repart
  # TODO: Discoverable Partitions Specification
  # TODO: Bootspec (w/ validation)

  # Resize partition on device in initrd?
  boot.initrd.systemd.repart = {
    enable = true;
    device = "/dev/nvme0n1p2";
  };

  # Resize & configure partitions during main system boot?
  systemd.repart = {
    enable = true; # ?? vs initrd?
    #partitions = {
    #  "10-root" = {
    #    Type = "root";
    #  };
    #  "20-home" = {
    #    SizeMaxBytes = "1536G";
    #    SizeMinBytes = "2G";
    #    Type = "home";
    #  };
    #};
  };


}
