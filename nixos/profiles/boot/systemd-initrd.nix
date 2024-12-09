{ config, lib, pkgs, ... }:
let
  inherit (lib) mkDefault;
  systemd-boot-based = with config.boot; loader.systemd-boot.enable || lanzaboote.enable;
in
{
  boot.initrd.systemd = {
    enable = systemd-boot-based;
    tpm2.enable = mkDefault systemd-boot-based;
    dbus.enable = mkDefault systemd-boot-based;

    # true  = unauthed-emerg-access,
    # <str> = hashed-su-passwd (authed-emerg-access)
    emergencyAccess = mkDefault false;

    #contents."/etc/hostname".text = config.networking.hostName;
    #extraBin = { umount=${pkgs.util-linux}/bin/umount; }; #            # Tools to add to `/bin`
    #extraConfig = "DefaultLimitCORE=infinity"; #                       # See: `man systemd-system.conf(5)`
    #initrdBin = []; #                                                  # Packages to include in `/bin` for stage1 emergency shell
    #managerEnvironment = { SYSTEMD_LOG_LEVEL = "debug"; }; #           # Env vars of PID 1. Not passed to started units.

    # Enable builtin systemd units
    #additionalUpstreamUnits=["debug-shell.service" "systemd-quotacheck.service"]; 

    # Packages providing systemd units/hooks
    #packages = [pkgs.systemd-cryptsetup-generator]; 
  };
}
