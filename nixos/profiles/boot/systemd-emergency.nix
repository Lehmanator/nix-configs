{ config, lib, pkgs, ... }: {
  systemd.enableEmergencyMode = true;
  boot.initrd.systemd = {
    # TODO: Set to hashed super user password to enable authentication in emergency mode
    emergencyAccess = lib.mkDefault true;
    enableEmergencyMode = lib.mkDefault true;

    # Packages to include in /bin for the stage 1 emergency shell
    initrdBin = [ pkgs.btrfs pkgs.btrfs-progs ];

    # extraBin  = {
    #   umount = "${pkgs.util-linux}/bin/umount";
    #   btrfs = "${lib.getExe pkgs.btrfs}";
    #   btrfs-progs = "${lib.getExe pkgs.btrfs-progs}";
    # };
  };
}
